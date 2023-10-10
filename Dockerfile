FROM python:3.10-slim
LABEL maintainer="wolfgang.huse@nutanix.com"
# Set the working directory in the container to /app
WORKDIR /nai-utils
COPY download-wrapper.sh /nai-utils/download-wrapper.sh
RUN apt update
RUN apt install gpustat curl -y
RUN curl -LO https://github.com/nutanix/nai-llm-k8s/archive/refs/tags/v0.1-rc3.tar.gz
RUN tar -xvf v0.1-rc3.tar.gz  --strip-components=1
RUN pip install -r llm/requirements.txt
RUN pip install $(grep -ivE "kubernetes" llm/requirements.txt)


ENTRYPOINT ["/nai-utils/download-wrapper.sh"]
