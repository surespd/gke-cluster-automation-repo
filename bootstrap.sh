#!/bin/bash

# ==============================================================================
# GKE AUTOMATION BOOTSTRAP SCRIPT
# This script prepares the GCP environment for Terraform by creating
# the remote state bucket and enabling necessary APIs.
# ==============================================================================

set -e # Exit on error

# Configuration - Change these to match your GCP Project
PROJECT_ID="your-gcp-project-id"
REGION="us-central1"
BUCKET_NAME="${PROJECT_ID}-tf-state"

echo "--------------------------------------------------------"
echo "🚀 Starting Bootstrap for Project: $PROJECT_ID"
echo "--------------------------------------------------------"

# 1. Set the active GCP project
echo "📍 Setting project context..."
gcloud config set project $PROJECT_ID

# 2. Enable necessary Google APIs
echo "⚙️  Enabling required APIs (Compute, Container, Storage)..."
gcloud services enable \
    compute.googleapis.com \
    container.googleapis.com \
    storage-api.googleapis.com

# 3. Create the GCS Bucket if it doesn't exist
if gsutil ls -b gs://$BUCKET_NAME >/dev/null 2>&1; then
    echo "✅ Bucket gs://$BUCKET_NAME already exists."
else
    echo "📦 Creating bucket gs://$BUCKET_NAME in $REGION..."
    gsutil mb -l $REGION gs://$BUCKET_NAME
    
    echo "🛡️  Enabling Object Versioning..."
    # Versioning allows you to recover older versions of your terraform state
    gsutil versioning set on gs://$BUCKET_NAME
fi

echo "--------------------------------------------------------"
echo "✨ Bootstrap Complete! You can now run ./deploy.sh"
echo "--------------------------------------------------------"