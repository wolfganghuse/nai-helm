FROM python:3.10-slim as base
FROM base as builder

RUN apt update
RUN apt install gcc curl -y
RUN mkdir /nai-utils
WORKDIR /nai-utils
RUN curl -LO https://github.com/nutanix/nai-llm-k8s/archive/refs/tags/v0.1-rc3.tar.gz
RUN tar -xvf v0.1-rc3.tar.gz  --strip-components=1
RUN mkdir /install
WORKDIR /install
RUN pip install  --prefix=/install $(grep -ivE "kubernetes" /nai-utils/llm/requirements.txt)

FROM base
COPY --from=builder /install /usr/local
COPY --from=builder /nai-utils /nai-utils
COPY download-wrapper.sh /nai-utils/download-wrapper.sh
WORKDIR /nai-utils

ENTRYPOINT ["/nai-utils/download-wrapper.sh"]

