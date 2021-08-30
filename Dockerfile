##############
# Base Image #
##############

FROM python:3.7.4-slim-buster as base

RUN apt-get update

ADD . /mlops
WORKDIR /mlops

RUN pip install --upgrade pip setuptools wheel \
 && pip install --no-cache-dir -r requirements.txt

ENV GUNICORN_CMD_ARGS="--bind=0.0.0.0"

EXPOSE 5500

######################
# MLFlow Local Image #
######################

FROM base as mlops_local

ENTRYPOINT ["mlflow", "ui", \
            "--backend-store-uri", "/mlflow", \
            "--host", "0.0.0.0", \
            "--port", "5500"]
