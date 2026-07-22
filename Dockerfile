FROM python:3.11-slim

ENV LANG=C.UTF-8
ENV PYTHONUNBUFFERED=1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    build-essential \
    gcc \
    g++ \
    libpq-dev \
    libldap2-dev \
    libsasl2-dev \
    libxml2-dev \
    libxslt1-dev \
    libjpeg-dev \
    zlib1g-dev \
    libffi-dev \
    libssl-dev \
    libzip-dev \
    liblcms2-dev \
    libblas-dev \
    libyaml-dev \
    libfreetype6-dev \
    libwebp-dev \
    libopenjp2-7 \
    libtiff6 \
    npm \
    node-less \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Create odoo user
RUN useradd -m -d /var/lib/odoo -U -s /bin/bash odoo

WORKDIR /opt

# Copy Odoo source
COPY odoo /opt/odoo

# Copy Enterprise source
COPY enterprise /opt/enterprise

# Copy configuration
COPY config /etc/odoo

# Copy custom requirements (optional)
COPY requirements.txt /tmp/custom-requirements.txt

# Install Python packages
RUN python -m pip install --upgrade pip setuptools wheel

# Install Odoo dependencies
RUN pip install --no-cache-dir -r /opt/odoo/requirements.txt

# Install custom dependencies (if any)
RUN if [ -f /tmp/custom-requirements.txt ]; then \
        pip install --no-cache-dir -r /tmp/custom-requirements.txt; \
    fi

# Copy entrypoint
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

# Create filestore directory
RUN mkdir -p /var/lib/odoo && \
    chown -R odoo:odoo /opt /var/lib/odoo /etc/odoo

USER odoo

EXPOSE 8069 8072

ENTRYPOINT ["/entrypoint.sh"]
