#!/bin/bash

# Install Nginx if not already installed
if ! dpkg -s nginx > /dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get -y install nginx
fi

# Create necessary directories if they don't exist
sudo mkdir -p /data/web_static/{releases/test,shared}
sudo touch /data/web_static/releases/test/index.html
echo "Hello, this is a test index page." | sudo tee /data/web_static/releases/test/index.html > /dev/null

# Create symbolic link /data/web_static/current
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current

# Give ownership of /data/ to ubuntu user and group
sudo chown -R ubuntu:ubuntu /data/

# Update Nginx configuration
config_file="/etc/nginx/sites-available/default"
sudo sed -i '/^\s*location \/static\/ {\s*$/a \\tlocation /hbnb_static/ {\n\t\talias /data/web_static/current/;\n\t}\n' "$config_file"

# Restart Nginx
sudo service nginx restart
