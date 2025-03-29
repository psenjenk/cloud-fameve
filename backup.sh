#!/bin/bash

# Load environment variables
if [ -f .env ]; then
    source .env
fi

# Create backup directory if it doesn't exist
mkdir -p backup

# Get current timestamp
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Backup database
echo "Backing up database..."
docker-compose exec -T db mysqldump -u root -p${MYSQL_ROOT_PASSWORD} ${MYSQL_DATABASE} > backup/database_${TIMESTAMP}.sql

# Backup WordPress files
echo "Backing up WordPress files..."
tar -czf backup/wordpress_${TIMESTAMP}.tar.gz ./app

# Upload to S3 if AWS credentials are configured
if [ ! -z "$AWS_ACCESS_KEY_ID" ] && [ ! -z "$AWS_SECRET_ACCESS_KEY" ] && [ ! -z "$AWS_BUCKET" ]; then
    echo "Uploading backups to S3..."
    aws s3 cp backup/database_${TIMESTAMP}.sql s3://${AWS_BUCKET}/backups/
    aws s3 cp backup/wordpress_${TIMESTAMP}.tar.gz s3://${AWS_BUCKET}/backups/
fi

# Clean up old backups (keep last 7 days)
echo "Cleaning up old backups..."
find backup -type f -mtime +7 -delete

echo "Backup completed successfully!" 