#!/bin/bash

# Jenkins install instructions for Ubuntu:

echo "this is a sample file $(date -R)" | tee /root/output.txt


sudo apt-get update -y

sudo apt-get install python -y
sudo apt-get install python-apt -y

sudo apt update -y

sudo git clone https://github.com/munireddy/setupInstructions.git
sudo chmod 777 ~/setupInstructions/Jenkins/jenkins.sh
sudo bash ~/setupInstructions/Jenkins/jenkins.sh




