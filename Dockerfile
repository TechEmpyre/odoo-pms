FROM python:3.11-slim

ENV LANG=C.UTF-8
ENV PYTHONUNBUFFERED=1
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    build-essential \
    gcc \
    g++ \
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
    postgresql-client \
 && rm -rf /var/lib/apt/lists/*

RUN useradd -m -d /var/lib/odoo -U -s /bin/bash odoo

WORKDIR /opt

COPY odoo /opt/odoo
COPY enterprise /opt/enterprise
COPY config /etc/odoo
COPY requirements.txt /tmp/custom-requirements.txt
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

RUN python -m pip install --upgrade pip setuptools wheel

RUN pip install --no-cache-dir -r /opt/odoo/requirements.txt

RUN if [ -s /tmp/custom-requirements.txt ]; then \
    pip install --no-cache-dir -r /tmp/custom-requirements.txt; \
fi

RUN mkdir -p /var/lib/odoo && \
    chown -R odoo:odoo /opt /var/lib/odoo /etc/odoo

USER odoo

EXPOSE 8069 8072

ENTRYPOINT ["/entrypoint.sh"]
