
FROM python:3.11-slim

ENV LANG=C.UTF-8

RUN apt-get update && apt-get install -y \
    git \
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
    libatlas-base-dev \
    node-less \
    npm \
    wkhtmltopdf \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -d /var/lib/odoo -U odoo

WORKDIR /opt

COPY odoo ./odoo
COPY enterprise ./enterprise

COPY requirements.txt .

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

COPY config /etc/odoo
#COPY custom_addons /mnt/custom-addons

COPY entrypoint.sh /

RUN chmod +x /entrypoint.sh

RUN chown -R odoo:odoo /opt
RUN chown -R odoo:odoo /var/lib/odoo

USER odoo

EXPOSE 8069 8072

ENTRYPOINT ["/entrypoint.sh"]
