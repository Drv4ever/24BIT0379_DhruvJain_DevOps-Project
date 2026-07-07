#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "=== Automating Git Push for Dhruv Jain (24BIT0379) ==="

# Initialize git repository if not already done
if [ ! -d .git ]; then
    echo "Initializing git repository..."
    git init
fi

# Add remote origin if not already added
if ! git remote | grep -q 'origin'; then
    echo "Adding remote origin..."
    git remote add origin https://github.com/Drv4ever/24BIT0379_DhruvJain_DevOps-Project.git
fi

# Set default branch name to main
git branch -M main

# Add all project files
echo "Staging files..."
git add index.html Dockerfile k8s-deployment.yaml Jenkinsfile 24BIT0379_DhruvJain_DevOps_Report.md

# Commit the changes
echo "Committing files..."
git commit -m "feat: complete Use Case 1 DevOps assignment files"

# Push to Github main branch
echo "Pushing to GitHub main branch..."
git push -u origin main

echo "=== Git Push Completed Successfully! ==="
