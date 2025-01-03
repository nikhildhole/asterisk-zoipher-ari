# Asterisk 22 Docker Image with Custom Configuration

This Docker image provides a ready-to-use environment for running Asterisk 22, a popular open-source PBX software. It includes Asterisk with custom configurations, as well as additional tools like Node.js, `sngrep`, and system utilities. This image is designed to quickly set up Asterisk for VoIP applications and testing.

## Features

- Asterisk 22 installation with custom configuration files
- Node.js and `wscat` installed for WebSocket testing
- Useful tools like `sngrep`, `systemctl`, and `netstat`
- Exposes common Asterisk ports: `5060` (SIP), `4569` (IAX2), `5038` (Asterisk Manager Interface)
- Exposes port `8088` for additional management or API access

## Ports Exposed

- **5060/UDP**: SIP signaling
- **5060/TCP**: SIP signaling
- **4569/UDP**: IAX2 signaling
- **5038/TCP**: Asterisk Manager Interface (AMI)
- **8088/TCP**: Web interface or additional API
- **8088/UDP**: Web interface or additional API

## Installation

### Prerequisites

You need to have Docker installed on your system. If you don't have Docker yet, you can follow the [official Docker installation guide](https://docs.docker.com/get-docker/) to set it up.

### Build the Docker Image

To build the Docker image, run the following command from the directory containing your Dockerfile:

```bash
docker build -t asterisk-docker .
