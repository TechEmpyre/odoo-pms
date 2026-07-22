FROM python:3.11-slim

ARG DB_HOST
ARG DB_PORT
ARG DB_USER
ARG DB_PASSWORD
ARG COOLIFY_URL
ARG COOLIFY_FQDN
ARG COOLIFY_BRANCH
ARG COOLIFY_RESOURCE_UUID

ENV LANG=C.UTF-8 \
    PYTHONUNBUFFERED=1 \
    DEBIAN_FRONTEND=noninteractive \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_NO_BUILD_ISOLATION=1

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

# Create Odoo user
RUN useradd -m -d /var/lib/odoo -U -s /bin/bash odoo

WORKDIR /opt

# Copy application files with correct ownership
COPY --chown=odoo:odoo odoo /opt/odoo
COPY --chown=odoo:odoo enterprise /opt/enterprise
COPY --chown=odoo:odoo custom_addons /opt/custom_addons
COPY --chown=odoo:odoo config /etc/odoo
COPY --chown=odoo:odoo requirements.txt /tmp/custom-requirements.txt
COPY --chown=odoo:odoo entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

# Upgrade packaging tools
RUN python -m pip install --upgrade \
    pip \
    setuptools==80.9.0 \
    wheel \
    build \
    packaging

# Install Odoo requirements
RUN pip install --no-build-isolation \
    --no-cache-dir \
    -r /opt/odoo/requirements.txt

# Install custom requirements
RUN if [ -s /tmp/custom-requirements.txt ]; then \
        pip install --no-build-isolation \
        --no-cache-dir \
        -r /tmp/custom-requirements.txt; \
    fi

# Create writable data directory only
RUN mkdir -p /var/lib/odoo && \
    chown odoo:odoo /var/lib/odoo

USER odoo

EXPOSE 8069 8072

ENTRYPOINT ["/entrypoint.sh"]
