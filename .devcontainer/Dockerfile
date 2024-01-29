FROM bitnami/python:3.8-debian-11

# Switch to root, to avoid permission issues
USER root

# Install redis-cli and other required utilities. No need to clean up afterwards
RUN apt-get update -qq --no-install-recommends \
 && apt-get upgrade -qq --no-install-recommends \
 && apt-get install -qq --no-install-recommends \
  build-essential libssl-dev zlib1g-dev libbz2-dev libpq-dev python3-dev \
  libreadline-dev libsqlite3-dev llvm libncurses5-dev libncursesw5-dev \
  xz-utils tk-dev libffi-dev liblzma-dev postgresql-server-dev-all git \
  redis openssh-client procps psmisc postgresql-client-13 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Minimum required env variables
ENV PROJECT_DIR=/classifiedads \
  DEBUG=True \
  TESTING=False \
  LOGLEVEL=INFO \
  DJANGO_SETTINGS_MODULE=classifiedads.settings \
  PIPENV_VENV_IN_PROJECT=1 \
  PIPENV_VERBOSITY=-1 \
  PYTHONWARNINGS="ignore:You're running the worker with superuser privileges:RuntimeWarning"

# Set up the working directory
RUN mkdir -p $PROJECT_DIR 
WORKDIR $PROJECT_DIR


# Copy user content and run on_build.sh as root if it exists
COPY .devcontainer .devcontainer
RUN [ ! -f .devcontainer/user/on_build.sh ] || bash .devcontainer/user/on_build.sh

# Creating the .venv inside the project is the only way to know the path of the virtualenv beforehand
ENV PIPENV_VENV_IN_PROJECT=1 \
  PIPENV_VERBOSITY=-1

RUN pip install pipenv

RUN git config --global --add safe.directory $PROJECT_DIR

# Makes the container not stop instantly, by waiting indefinitly.
# Also waits for SIGTERM or SIGTERM signals, to instantly stop the container when needed
CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"