#!/bin/bash

# Define source files and destination directory
SRC_FILES=(
    "/home/alex/docker-compose/pihole/docker-compose.yml"
    "/etc/systemd/system/pihole.service"
)
DEST_DIR="/raid/docker-backup"

# Get current date and time for the backup name
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

# Create destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

# Backup files
for FILE in "${SRC_FILES[@]}"; do
    if [ -f "$FILE" ]; then
        cp "$FILE" "$DEST_DIR/$(basename "$FILE").$TIMESTAMP"
        echo "Backed up $FILE to $DEST_DIR/$(basename "$FILE").$TIMESTAMP"
    else
        echo "File $FILE does not exist."
    fi
done

# Optional: Remove backups older than 7 days
find "$DEST_DIR" -type f -mtime +7 -exec rm {} \;

echo "Backup completed."
 
