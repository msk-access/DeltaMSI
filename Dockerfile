################## Base Image ##########
ARG PYTHON_VERSION="3.9.7"
FROM --platform=linux/amd64 python:${PYTHON_VERSION}

################## ARGUMENTS/Environments ##########
ARG BUILD_DATE
ARG BUILD_VERSION
ARG LICENSE="Apache-2.0"
ARG DELTA_MSI_VERSION
ARG VCS_REF

################## METADATA ########################
LABEL org.opencontainers.image.vendor="MSKCC"
LABEL org.opencontainers.image.authors="Carmelina Charalambous (charalk@mskcc.org)"

LABEL org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.version=${BUILD_VERSION} \
    org.opencontainers.image.licenses=${LICENSE} \
    org.opencontainers.image.version.pvs=${DELTA_MSI_VERSION} \
    org.opencontainers.image.vcs-url="https://github.com/msk-access/DeltaMSI.git" \
    org.opencontainers.image.vcs-ref=${VCS_REF}

LABEL org.opencontainers.image.description="This container uses python3.9.7 as the base image to build \
    DeltaMSI version ${DELTA_MSI_VERSION}"

################## INSTALL ##########################

WORKDIR /app
ADD . /app

RUN pip3 install --no-cache-dir --user pipenv \
  && cd /code \
  && python3.9.7 -m pipenv install

ENTRYPOINT ["python3", "-m", "pipenv", "run", "python", "deltamsi/app.py"]
