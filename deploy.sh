#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Sync files to S3, making sure only current files exist
aws s3 sync . s3://edulilo.com \
    --delete \
    --exclude ".git/*" \
    --exclude "deploy.sh"

# Invalidate CloudFront cache
aws cloudfront create-invalidation \
    --distribution-id E3TJ3RWT5GKKGJ \
    --paths "/*"

echo "✅ Blog successfully deployed to s3://edulilo.com and CloudFront cache invalidated"
