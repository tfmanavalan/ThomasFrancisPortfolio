#!/bin/bash

# GitHub + Google Cloud Run Setup Script
# Replace YOUR-GITHUB-USERNAME with your actual GitHub username below

# Configuration
PROJECT_ID="thomas-francis-portfolio"
GITHUB_USERNAME="tfmanavalan"  # ← CHANGE THIS!
POOL_NAME="github-pool"
PROVIDER_NAME="github-provider"
SERVICE_ACCOUNT="github-actions@${PROJECT_ID}.iam.gserviceaccount.com"

echo "🚀 Setting up Workload Identity Federation for GitHub Actions"
echo "Project: $PROJECT_ID"
echo "GitHub User: $GITHUB_USERNAME"
echo ""

# Get project number
PROJECT_NUMBER=$(gcloud projects describe $PROJECT_ID --format="value(projectNumber)")
echo "✅ Project Number: $PROJECT_NUMBER"

# Check if pool exists, if not create it
if gcloud iam workload-identity-pools describe $POOL_NAME --location=global &>/dev/null; then
    echo "✅ Workload Identity Pool already exists"
else
    echo "📦 Creating Workload Identity Pool..."
    gcloud iam workload-identity-pools create $POOL_NAME \
        --location=global \
        --display-name="GitHub Actions Pool"
fi

# Check if provider exists, if not create it
if gcloud iam workload-identity-pools providers describe $PROVIDER_NAME --location=global --workload-identity-pool=$POOL_NAME &>/dev/null; then
    echo "✅ Workload Identity Provider already exists"
else
    echo "📦 Creating Workload Identity Provider..."
    gcloud iam workload-identity-pools providers create-oidc $PROVIDER_NAME \
        --location=global \
        --workload-identity-pool=$POOL_NAME \
        --display-name="GitHub Provider" \
        --issuer-uri="https://token.actions.githubusercontent.com" \
        --attribute-mapping="google.subject=assertion.sub,attribute.actor=assertion.actor,attribute.repository=assertion.repository,attribute.repository_owner=assertion.repository_owner" \
        --attribute-condition="assertion.repository_owner=='${GITHUB_USERNAME}'"
fi

# Grant permissions to service account
echo "🔐 Granting IAM permissions..."
gcloud iam service-accounts add-iam-policy-binding $SERVICE_ACCOUNT \
    --role="roles/iam.workloadIdentityUser" \
    --member="principalSet://iam.googleapis.com/projects/${PROJECT_NUMBER}/locations/global/workloadIdentityPools/${POOL_NAME}/attribute.repository/${GITHUB_USERNAME}/thomas-francis-portfolio"

# Get the provider name
WIF_PROVIDER=$(gcloud iam workload-identity-pools providers describe $PROVIDER_NAME \
    --location=global \
    --workload-identity-pool=$POOL_NAME \
    --format="value(name)")

echo ""
echo "============================================"
echo "✅ Setup Complete!"
echo "============================================"
echo ""
echo "📋 Add these 3 secrets to your GitHub repository:"
echo ""
echo "Secret #1 - GCP_PROJECT_ID:"
echo "$PROJECT_ID"
echo ""
echo "Secret #2 - WIF_PROVIDER:"
echo "$WIF_PROVIDER"
echo ""
echo "Secret #3 - SERVICE_ACCOUNT:"
echo "$SERVICE_ACCOUNT"
echo ""
echo "============================================"
echo ""
echo "🌐 To add secrets in GitHub:"
echo "1. Go to: https://github.com/${GITHUB_USERNAME}/thomas-francis-portfolio/settings/secrets/actions"
echo "2. Click 'New repository secret'"
echo "3. Add the 3 secrets above"
echo ""
