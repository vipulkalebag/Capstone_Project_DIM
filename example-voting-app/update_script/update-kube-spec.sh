#!/bin/bash

set -x  # Enable debugging to print each command being executed.

git clone https://$GITHUB_TOKEN@github.com/vipulkalebag/Capstone_Project_DIM.git

# cd example-voting-app || exit 1
cd Capstone_Project_DIM/example-voting-app || exit 1

ls -a Capstone_Project_DIM


# Export the build number from CodeBuild
export BUILD_NUMBER=${CODEBUILD_BUILD_NUMBER}

# List of microservices and their corresponding ECR repository URLs
declare -A ECR_REPOS
ECR_REPOS["result"]="654654478631.dkr.ecr.ap-south-1.amazonaws.com/result-repo"
ECR_REPOS["vote"]="654654478631.dkr.ecr.ap-south-1.amazonaws.com/vote-repo"
ECR_REPOS["worker"]="654654478631.dkr.ecr.ap-south-1.amazonaws.com/worker-repo"

# List of microservices (adjust these names to match your services)
MICROSERVICES=("result" "vote" "worker")

# Loop through each microservice and update the image tag in its Kubernetes manifest file
for SERVICE in "${MICROSERVICES[@]}"; do
  # Construct the image tag using only the build number
  IMAGE_TAG="${BUILD_NUMBER}"  # Use only the build number as the image tag
  # Get the ECR repo URL for the current service
  ECR_REPO_URL="${ECR_REPOS[$SERVICE]}"
# chmod -R +rw /Capstone_Project_DIM/

# chmod -R +rw Capstone_Project_DIM/example-voting-app/kube-spec/
  # DEPLOYMENT_FILE="Capstone_Project_DIM/example-voting-app/kube-spec/$SERVICE-deployment.yml"

  # Replace the image tag in the corresponding Kubernetes deployment file
  sed -i "s|image:.*|image: $ECR_REPO_URL/$SERVICE:$IMAGE_TAG|g" "./kube-spec/$SERVICE-deployment.yml"
  # if [ -f "$DEPLOYMENT_FILE" ]; then
  #   # Replace the image tag in the corresponding Kubernetes deployment file
  #   sed -i "s|image:.*|image: $ECR_REPO_URL/$SERVICE:$IMAGE_TAG|g" "$DEPLOYMENT_FILE"
  # else
  #   echo "Error: Kubernetes manifest for $SERVICE not found at $DEPLOYMENT_FILE!"
  # fi
done

cat "./kube-spec/$SERVICE-deployment.yml"

# export GIT_DISCOVERY_ACROSS_FILESYSTEM=1

# git remote add origin https://$GITHUB_TOKEN@github.com/vipulkalebag/Capstone_Project_DIM.git

# git remote add origin https://github.com/vipulkalebag/Capstone_Project_DIM.git

# git branch -m main

# git pull origin main --rebase

# Add the modified files to Git

git config --global user.email "vipulkalebag.1317@gmail.com"
git config --global user.name "vipulkalebag"

git add .

# Commit the changes
git commit -m "Update Kubernetes manifests for microservices with ECR image"

# git remote set-url origin https://$GITHUB_TOKEN@github.com/vipulkalebag/Capstone_Project_DIM.git
# Push the changes back to the Git repository
# git push 
git push origin main

# rm -rf /Capstone_Project_DIM/
