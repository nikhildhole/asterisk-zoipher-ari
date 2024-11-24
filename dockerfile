# Use Debian 11 as the base image
FROM debian:11

# Metadata information
LABEL maintainer="Nikhil Dhole nikhildadadhole@gmail.com"
LABEL version="1.0"
LABEL description="Asterisk 22 Docker image with custom configuration, Node.js, sngrep, and other utilities."
LABEL creation_date="2024-11-23"
LABEL purpose="Asterisk PBX setup for VoIP with additional tools and configurations."

# Update and upgrade the system
RUN apt update && apt full-upgrade -y

# Install required dependencies
RUN apt -y install build-essential git curl wget libnewt-dev libssl-dev libncurses5-dev subversion libsqlite3-dev libjansson-dev libxml2-dev uuid-dev default-libmysqlclient-dev sngrep vim curl

# Install Asterisk
RUN cd /usr/src/ && \
    curl -O https://downloads.asterisk.org/pub/telephony/asterisk/asterisk-22-current.tar.gz && \
    tar xvf asterisk-22-current.tar.gz && \
    cd asterisk-22*/ && \
    contrib/scripts/get_mp3_source.sh && \
    contrib/scripts/install_prereq install && \
    ./configure && \
    make && \
    make install && \
    make progdocs && \
    make samples && \
    make config && \
    ldconfig

# Run the commands you need to execute
RUN groupadd asterisk && \
    useradd -r -d /var/lib/asterisk -g asterisk asterisk && \
    usermod -aG audio,dialout asterisk && \
    chown -R asterisk:asterisk /etc/asterisk && \
    chown -R asterisk:asterisk /var/lib/asterisk && \
    chown -R asterisk:asterisk /var/log/asterisk && \
    chown -R asterisk:asterisk /var/spool/asterisk && \
    chown -R asterisk:asterisk /usr/lib/asterisk

# Copy files
COPY ./etc/default/asterisk /etc/default/asterisk
COPY ./etc/asterisk/asterisk.conf /etc/asterisk/asterisk.conf
COPY ./etc/asterisk/pjsip.conf /etc/asterisk/pjsip.conf
COPY ./etc/asterisk/extensions.conf /etc/asterisk/extensions.conf

# Expose Asterisk ports
EXPOSE 5060/udp 5061/udp

# Set the default command
CMD ["asterisk", "-f"]
