FROM registry.opensource.zalan.do/stups/ubuntu:16.04.2-5

#=======================
# General Configuration
#=======================
ENV REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
RUN apt-get update && apt-get install -y python-dev python-zmq python-pip && rm -rf /var/lib/apt/lists/*

#==============
# Expose Ports
#==============
EXPOSE 8089
EXPOSE 5557
EXPOSE 5558

#======================
# Install dependencies
#======================
COPY requirements.txt /tmp/
RUN pip install -r /tmp/requirements.txt

#=====================
# Start docker-locust
#=====================
COPY . /opt/
WORKDIR /opt
ENV PYTHONPATH .
CMD ["/usr/bin/python", "src/start.py"]
