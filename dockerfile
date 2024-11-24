# Use Debian 11 as base image
FROM debian:11

# Metadata information
LABEL maintainer="Nikhil Dhole nikhildadadhole@gmail.com"
LABEL version="1.0"
LABEL description="Asterisk 22 Docker image with custom configuration, Node.js, sngrep, and other utilities."
LABEL creation_date="2024-11-23"
LABEL purpose="Asterisk PBX setup for VoIP with additional tools and configurations."

# Set the working directory
WORKDIR /usr/src/

# Run initial apt-get commands and install required packages
RUN apt update && \
    apt full-upgrade -y && \
    [ -f /var/run/reboot-required ] && sudo reboot -f || echo "No reboot required" && \
    apt -y install build-essential git curl wget libnewt-dev libssl-dev libncurses5-dev subversion libsqlite3-dev libjansson-dev libxml2-dev uuid-dev default-libmysqlclient-dev

# Download and extract Asterisk source
RUN curl -O https://downloads.asterisk.org/pub/telephony/asterisk/asterisk-22-current.tar.gz && \
    tar xvf asterisk-22-current.tar.gz && \
    cd asterisk-22*/

# Install prerequisites and configure Asterisk
RUN cd asterisk-22*/ && \
    contrib/scripts/get_mp3_source.sh && \
    contrib/scripts/install_prereq install && \
    ./configure

# Set the default command to run when the container starts
CMD ["/bin/bash"]
