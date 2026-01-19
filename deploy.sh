#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# --- Configuration ---
# You can hardcode your project ID here or pass it as an environment variable
PROJECT_ID="your-gcp-project-id"

# --- Input Validation ---
ENV=$1    # dev, stage, or prod
ACTION=$2 # plan, apply, or destroy

if [[ ! "$ENV" =~ ^(dev|stage|prod)$ ]]; then
    echo "❌ Error: Invalid environment. Usage: ./deploy.sh [dev|stage|prod] [plan|apply|destroy]"
    exit 1
fi

if [[ ! "$ACTION" =~ ^(plan|apply|destroy)$ ]]; then
    echo "❌ Error: Invalid action. Usage: ./deploy.sh [dev|stage|prod] [plan|apply|destroy]"
    exit 1
fi

echo "--------------------------------------------------------"
echo "🚀 Target Environment: $ENV"
echo "🛠️  Action:             $ACTION"
echo "--------------------------------------------------------"

# 1. Run Bootstrap automatically to ensure infrastructure is ready
# (Optional: Comment this out if you prefer running bootstrap manually)
./bootstrap.sh

# 2. Navigate to the environment-specific directory
cd environments/$ENV

# 3. Initialize Terraform 
# -reconfigure is used to ensure we switch state prefixes correctly
echo "🔄 Initializing Terraform for $ENV..."
terraform init -reconfigure

# 4. Execute the Terraform command
if [ "$ACTION" == "plan" ]; then
    echo "📋 Generating Execution Plan..."
    terraform plan
elif [ "$ACTION" == "apply" ]; then
    echo "⚠️  Applying changes to $ENV in 5 seconds... (Ctrl+C to cancel)"
    sleep 5
    terraform apply -auto-approve
elif [ "$ACTION" == "destroy" ]; then
    echo "🧨 WARNING: Destroying $ENV infrastructure in 10 seconds..."
    sleep 10
    terraform destroy -auto-approve
fi

echo "--------------------------------------------------------"
echo "✅ $ENV deployment $ACTION finished successfully!"
echo "--------------------------------------------------------"