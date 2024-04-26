#!/bin/bash

# Update system packages
sudo apt update -y

# Install Nginx
sudo apt install nginx -y

# Gather server details
hostname=$(hostname)
ip_address=$(hostname -I | cut -d" " -f1)

# Create basic HTML index file
echo "<h1>Server Details asg2</h1><p><strong>Hostname:</strong> $hostname </p><p><strong>IP Address:</strong> $ip_address</p>" | sudo tee /var/www/html/index.html

# Start and enable Nginx
sudo systemctl start nginx
sudo systemctl enable nginx