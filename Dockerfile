##############
# Base Image #
##############

FROM python:3.7.4-slim-buster as base

ENV MLFLOW_HOME /mlflow
ENV SERVER_PORT 5500
ENV SERVER_HOST 0.0.0.0
ENV FILE_STORE ${MLFLOW_HOME}
ENV ARTIFACT_STORE ${MLFLOW_HOME}

RUN mkdir -p ${FILE_STORE} && \
    mkdir -p ${ARTIFACT_STORE}

VOLUME ["${FILE_STORE}", "${ARTIFACT_STORE}"]

RUN apt-get update
RUN pip install --upgrade pip setuptools wheel 

ADD . /mlops
WORKDIR /mlops

RUN pip install --no-cache-dir -r requirements.txt

RUN chmod +x ./scripts/run.sh

EXPOSE ${SERVER_PORT}

ENTRYPOINT ["./scripts/run.sh"]
