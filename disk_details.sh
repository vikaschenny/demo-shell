#!/bin/bash

# Get disk details using df command
disk_details=$(df -h)

# Remove the first line (header) from the df output
disk_details=$(echo "$disk_details" | sed '1d')

# Initialize JSON object
json="{\"disks\": ["

# Loop through each line of disk details
while IFS= read -r line; do
    # Extract disk information
    filesystem=$(echo "$line" | awk '{print $1}')
    size=$(echo "$line" | awk '{print $2}')
    used=$(echo "$line" | awk '{print $3}')
    available=$(echo "$line" | awk '{print $4}')
    capacity=$(echo "$line" | awk '{print $5}')
    mount_point=$(echo "$line" | awk '{print $6}')

    # Add disk information to JSON
    json="$json{\"filesystem\": \"$filesystem\", \"size\": \"$size\", \"used\": \"$used\", \"available\": \"$available\", \"capacity\": \"$capacity\", \"mount_point\": \"$mount_point\"},"
done <<< "$disk_details"

# Remove trailing comma and close JSON object
json=$(echo "$json" | sed 's/,$//')
json="$json]}"

# Print JSON
echo "$json"

