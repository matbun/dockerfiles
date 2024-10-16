# Base image
FROM nvcr.io/nvidia/pytorch:24.09-py3 as build

RUN apt-get update && apt-get install -y build-essential curl python3.10-venv
ENV VIRTUAL_ENV=/opt/venv \
    PATH="/opt/venv/bin:$PATH"

COPY ./requirements.txt .

# User python3.10 explicitly to force /opt/venv/bin/python to point to python3.10. Needed to link
# /usr/local/bin/python3.10 (in the app image) to /usr/bin/python3.10 (in the builder image)
RUN python3.10 -m venv /opt/venv && \
    pip install --no-cache-dir torch --index-url https://download.pytorch.org/whl/cu124 && \
    pip install --no-cache-dir -r requirements.txt


# App image
FROM python:3.10-slim
COPY --from=build /opt/venv /opt/venv

# Link /usr/local/bin/python3.10 (in the app image) to /usr/bin/python3.10 (in the builder image)
RUN ln -s /usr/local/bin/python3.10 /usr/bin/python3.10

# Activate the virtualenv in the container
# See here for more information:
# https://pythonspeed.com/articles/multi-stage-docker-python/
ENV PATH="/opt/venv/bin:$PATH"
