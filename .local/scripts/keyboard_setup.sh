#!/bin/bash

# requires keyd (https://github.com/rvaiya/keyd)
CONFIG_PATH="/etc/keyd/default.conf"

# Ensure the directory exists
sudo mkdir -p /etc/keyd

# Write the configuration to the file
sudo tee "$CONFIG_PATH" > /dev/null <<EOF
[ids]

*

[main]
esc = overload(control, esc)
EOF

# Restart keyd service to apply changes
sudo systemctl restart keyd

echo "Configuration updated successfully."

