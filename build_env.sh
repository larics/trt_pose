#!/bin/bash

# Define the repositories and their directories
declare -A repos=(
    ["trt_pose"]="https://github.com/larics/trt_pose.git"
    ["torch2trt"]="https://github.com/NVIDIA-AI-IOT/torch2trt.git"
    ["jetcam"]="https://github.com/NVIDIA-AI-IOT/jetcam.git"
)

# Function to clone and install a repository
install_repo() {
    local repo_name=$1
    local repo_url=$2

    # Clone the repository
    if [ -d "$repo_name" ]; then
        echo "Repository $repo_name already exists. Pulling latest changes..."
        cd $repo_name && git pull
    else
        echo "Cloning $repo_name..."
        git clone $repo_url
    fi

    # Enter the directory
    cd $repo_name

    # Run setup.py install commands
    echo "Installing $repo_name..."
    python3 setup.py install
    python3 setup.py install --plugins

    # Return to the parent directory
    cd ..
}

# Clone and install each repository
for repo in "${!repos[@]}"; do
    install_repo $repo ${repos[$repo]}
done

echo "All repositories have been installed."
