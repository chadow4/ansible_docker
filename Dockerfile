FROM python:3.11-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ansible sshpass bash coreutils iputils-ping net-tools && \
    pip install --no-cache-dir \
    PyYAML requests pyvmomi jmespath paramiko pyvim && \
    ansible-galaxy collection install community.vmware && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /root/.ansible /tmp/* /var/tmp/*

WORKDIR /workspace

VOLUME ["/workspace"]

CMD ["/bin/bash"]
