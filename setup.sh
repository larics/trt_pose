#!/bin/bash

# Function to clone a repository and run the setup commands
install_repo() {
  REPO_URL=$1
  REPO_NAME=$(basename $REPO_URL .git)

  # Clone the repository
  if [ ! -d "$REPO_NAME" ]; then
    git clone $REPO_URL
  else
    echo "$REPO_NAME already exists, skipping clone."
  fi

  # Enter the repository directory
  cd $REPO_NAME

  # Run setup.py commands
  python3 setup.py install
  python3 setup.py install --plugins

  # Go back to the previous directory
  cd ..
}

# Install necessary dependencies
sudo apt-get update
sudo apt-get install -y python3-pip git

# Clone and install repositories
install_repo https://github.com/NVIDIA-AI-IOT/trt_pose
install_repo https://github.com/NVIDIA-AI-IOT/trt_hand_pose
install_repo https://github.com/NVIDIA-AI-IOT/torch2trt
install_repo https://github.com/NVIDIA-AI-IOT/jetcam


