ARG OPENSTACK_RELEASE=2023.1

FROM ubuntu:22.04
LABEL vendor="cedrickoka/octavia-amphora-builder" maintainer="okacedrick@gmail.com" version="1.0.0"

SHELL ["/bin/sh", "-xo", "pipefail", "-c"]

RUN apt update && \
	apt -y install \
		debootstrap \
		git \
		kpartx \
		python3-pip \
		qemu-utils && \
	pip3 install --no-cache-dir -U python-openstackclient -c https://releases.openstack.org/constraints/upper/master && \
	pip3 install --no-cache-dir -U diskimage-builder && \
	git clone -b stable/$OPENSTACK_RELEASE https://opendev.org/openstack/octavia.git

#RUN cd octavia/diskimage-create && \
#	./diskimage-create.sh && \
#	openstack image create amphora --container-format bare --disk-format qcow2 --private --tag amphora --file amphora-x64-haproxy.qcow2 --property hw_architecture='x86_64' --property hw_rng_model=virtio --project service
