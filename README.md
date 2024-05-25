# NodeISP Deployment Scripts

This repository contains the scripts used to deploy the NodeISP project.

## Usage

Notes: To deploy the project, run the following command on a freshly provisioned Debian 12 or Ubuntu 22.04/24.04 server
with Docker installed.

1. Deploy a new server, running either Debian 12 or Ubuntu 22.04
2. Follow the docker installation instructions for your distribution (https://docs.docker.com/engine/install/debian/
   or https://docs.docker.com/engine/install/ubuntu/)
3. Install git
4. Clone this repository
5. Run the deployment script

```bash
apt update && apt upgrade -y

sudo apt install -y git software-properties-common curl apt-transport-https ca-certificates

# Add Docker GPG key to apt (Debian 12 and Ubuntu 22.04/24.04)
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Debian12 
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update


# Ubuntu 22.04 or 24.04
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install docker and docker-compose
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Clone the NodeISP deployment repository
cd /opt/
git clone https://github.com/The-IT-Dept/node-isp-deploy.git nodeisp


# Run the configuration script, answer the questions and wait for the script to finish
cd nodeisp
./setup.sh

# Start the services
docker compose up -d

# Check the status of the services, and wait till the nodeisp-app service is healthy.
docker compose ps
```
