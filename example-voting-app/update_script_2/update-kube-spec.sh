set -x  # Enable debugging to print each command being executed.

git clone https://$GITHUB_TOKEN@github.com/vipulkalebag/Capstone_Project_DIM.git

# cd example-voting-app || exit 1
cd Capstone_Project_DIM/example-voting-app || exit 1

ls -a Capstone_Project_DIM


# Export the build number from CodeBuild
export BUILD_NUMBER=${CODEBUILD_BUILD_NUMBER}

ECR_REPO_URL="654654478631.dkr.ecr.ap-south-1.amazonaws.com/result-repo"

IMAGE_TAG="${BUILD_NUMBER}" # Replace ${BUILD_NUMBER} dynamically

DEPLOYMENT_FILE="./kube-spec/result-deployment.yml"

# Check if the deployment file exists
if [ -f "$DEPLOYMENT_FILE" ]; then
  # Update the image tag in the Kubernetes deployment file
  sed -i "s|image:.*|image: ${ECR_REPO_URL}:${IMAGE_TAG}|g" "$DEPLOYMENT_FILE"
  
  echo "Updated deployment file for result."

  # Print the updated deployment file for verification
  cat "$DEPLOYMENT_FILE"
else
  echo "Error: Deployment file $DEPLOYMENT_FILE not found!"
  exit 1
fi

#   echo "Updated deployment file for result."

# cat "./kube-spec/$DEPLOYMENT_FILE-deployment.yml"

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

