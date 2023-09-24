# For more information, please refer to https://aka.ms/vscode-docker-python
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive

EXPOSE 8000

# Keeps Python from generating .pyc files in the container
# ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
# ENV PYTHONUNBUFFERED=1

RUN apt-get update && \
	apt-get install -y sudo \
	build-essential curl \
	libcurl4-openssl-dev \
	libssl-dev wget \
	python3-pip \
    locales \
	ffmpeg \
	git && \
	pip3 install --upgrade pip

# Configure system locale
RUN locale-gen en_US.UTF-8
RUN update-locale en_US.UTF-8

# Install pip requirements
COPY requirements.txt .
RUN python3 -m pip install -r requirements.txt

WORKDIR /app
COPY . /app

# Creates a non-root user with an explicit UID and adds permission to access the /app folder
# For more info, please refer to https://aka.ms/vscode-docker-python-configure-containers
RUN adduser -u 5678 --disabled-password --gecos "" appuser && chown -R appuser /app
USER appuser

# During debugging, this entry point will be overridden. For more information, please refer to https://aka.ms/vscode-docker-python-debug
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "-k", "uvicorn.workers.UvicornWorker", "main:app"]
