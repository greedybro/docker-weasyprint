FROM debian:buster-slim

ARG WEASYPRINT_VERSION

# Install dependencies
RUN apt update \
    && apt install -y --no-install-recommends \
    build-essential \
    python3-dev \
    libffi-dev \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    python3-cffi \
    libcairo2 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libgdk-pixbuf2.0-0 \
    shared-mime-info \
    && rm -rf /var/lib/apt/lists/*

# Install Weasyprint
RUN pip3 install weasyprint==$WEASYPRINT_VERSION

# Clean dependancies
RUN apt remove --purge -y \
    python3-dev \
    libffi-dev \
    build-essential \
    && apt autoremove -y

ENTRYPOINT ["weasyprint"]
