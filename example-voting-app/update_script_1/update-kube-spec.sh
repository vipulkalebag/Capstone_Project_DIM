set -x  # Enable debugging to print each command being executed.

git clone https://$GITHUB_TOKEN@github.com/vipulkalebag/Capstone_Project_DIM.git

# cd example-voting-app || exit 1
cd Capstone_Project_DIM/example-voting-app || exit 1

ls -a Capstone_Project_DIM
#!/bin/bash

# Variables for vote-repo
ECR_REPO_URL="654654478631.dkr.ecr.ap-south-1.amazonaws.com/vote-repo"
IMAGE_TAG="${BUILD_NUMBER}" # Replace ${BUILD_NUMBER} dynamically
DEPLOYMENT_FILE="./kube-spec/vote-deployment.yml"

# Check if the deployment file exists
if [ -f "$DEPLOYMENT_FILE" ]; then
  # Update the image tag in the Kubernetes deployment file
  sed -i "s|image:.*|image: ${ECR_REPO_URL}:${IMAGE_TAG}|g" "$DEPLOYMENT_FILE"
  echo "Updated deployment file for vote."
  
  # Apply the updated deployment
  cat "$DEPLOYMENT_FILE"
  echo "Applied deployment for vote."
else
  echo "Error: Deployment file for vote not found at ${DEPLOYMENT_FILE}!"
fi

git config --global user.email "vipulkalebag.1317@gmail.com"
git config --global user.name "vipulkalebag"

git add .

# Commit the changes
git commit -m "Update Kubernetes manifests for microservices with ECR image"

# git remote set-url origin https://$GITHUB_TOKEN@github.com/vipulkalebag/Capstone_Project_DIM.git
# Push the changes back to the Git repository
# git push 
git push origin main

