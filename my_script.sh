#!/bin/bash

set -e 

# 1. Update System
sudo apt update && sudo apt upgrade -y

# 2. hangul install and settings
sudo apt autoremove -y ibus ibus-hangul
sudo apt install -y ibus ibus-hangul 
ibus-daemon -rd
ibus restart


# 3. install essential package
sudo apt install -y software-properties-common apt-transport-https curl wget git build-essential python3-pip python3-venv unzip locales gnupg lsb-release

# 4. setting locale
sudo locale-gen ko_KR.UTF-8
sudo update-locale LANG=ko_KR.UTF-8

# 5. Install VS Code
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
sudo apt update
sudo apt install -y code

# 6. VS Code Extension Package Install
code --install-extension ms-python.python
code --install-extension ms-toolsai.jupyter
code --install-extension GitHub.copilot

# 7. Python Virtual Environment and Ai Library Install
python3 -m venv ~/ai-env
source ~/ai-env/bin/activate
pip3 install --upgrade pip
pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
pip3 install transformers datasets accelerate

echo "Install Complete. Virtual Env activate: source ~/ai-env/bin/activate"

