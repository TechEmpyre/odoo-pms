FROM python:3.11-slim

ENV LANG=C.UTF-8
ENV PYTHONUNBUFFERED=1
ENV DEBIAN_FRONTEND=noninteractive
ENV PIP_NO_CACHE_DIR=1
ENV PIP_DISABLE_PIP_VERSION_CHECK=1
ENV PIP_NO_BUILD_ISOLATION=1

# Install system packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    build-essential \
    gcc \
    g++ \
    python3-dev \
    pkg-config \
    libpq-dev \
    libldap2-dev \
    libsasl2-dev \
    libxml2-dev \
    libxslt1-dev \
    libjpeg62-turbo-dev \
    zlib1g-dev \
    libffi-dev \
    libssl-dev \
    libzip-dev \
    libyaml-dev \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Create odoo user
RUN useradd -m -d /var/lib/odoo -U -s /bin/bash odoo

WORKDIR /opt

# Copy sources
COPY odoo /opt/odoo
COPY enterprise /opt/enterprise
COPY config /etc/odoo
COPY requirements.txt /tmp/custom-requirements.txt
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

# Upgrade build tools first
RUN python -m pip install --upgrade \
    pip \
    setuptools \
    wheel \
    build \
    packaging

# Install pkg_resources provider
RUN pip install setuptools==80.9.0

# Install Odoo requirements
RUN pip install --no-build-isolation \
    --no-cache-dir \
    -r /opt/odoo/requirements.txt

# Install custom requirements (if any)
RUN if [ -s /tmp/custom-requirements.txt ]; then \
    pip install --no-build-isolation \
    --no-cache-dir \
    -r /tmp/custom-requirements.txt; \
fi

# Create data directory
RUN mkdir -p /var/lib/odoo && \
    chown -R odoo:odoo /opt /var/lib/odoo /etc/odoo

USER odoo

EXPOSE 8069 8072

ENTRYPOINT ["/entrypoint.sh"]
