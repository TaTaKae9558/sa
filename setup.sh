#!/bin/bash

# Kill all screen and tmux sessions
sudo pkill screen
sudo pkill tmux

# Update package list and install necessary packages
sudo apt update
sudo apt install -y zip unzip wget curl

# Install Docker
sudo apt-get install -y ca-certificates curl gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Start Docker service and enable it to start on boot
sudo systemctl start docker
sudo systemctl enable docker

# Install Satori
cd ~
sudo wget -P ~/ https://satorinet.io/static/download/linux/satori.zip
sudo unzip ~/satori.zip
sudo rm ~/satori.zip
cd ~/.satori
sudo apt-get install -y python3-venv

# Run the installation scripts
if sudo bash install.sh > ~/install.log 2>&1; then
  echo "install.sh executed successfully." | tee -a ~/install.log
  # Wait 10 seconds before running the next script
  sleep 10
  sudo usermod -aG docker $(whoami) || true
  if bash install_service.sh >> ~/install.log 2>&1; then
    echo "install_service.sh executed successfully." | tee -a ~/install.log
  else
    echo "install_service.sh failed." | tee -a ~/install.log
    exit 1
  fi
else
  echo "install.sh failed." | tee -a ~/install.log
  exit 1
fi

echo "Setup completed successfully." | tee -a ~/install.log

# Reload systemd manager configuration
sudo systemctl daemon-reload
# Enable and start the satori service
sudo systemctl enable satori.service
sudo systemctl start satori.service
# Check the status of the satori.service
sudo systemctl status satori.service | tee -a ~/install.log
