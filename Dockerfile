FROM python:3.11-slim

RUN apt-get update && \
    apt-get install -y ansible sshpass bash coreutils iputils-ping net-tools && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir \
    PyYAML \
    requests \
    pyvmomi \
    jmespath \
    paramiko \
    pyvim


RUN ansible-galaxy collection install community.vmware

WORKDIR /workspace


VOLUME ["/workspace"]

CMD ["/bin/bash"]