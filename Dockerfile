FROM dustynv/l4t-pytorch:r35.3.1

LABEL maintainer=filip.zoric@fer.hr 

RUN apt-get install -y \
    curl \
    lsb-release

# Remove opencv
RUN apt-get purge -y '*opencv*'

# Install ROS
RUN sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
RUN apt-get update 
RUN apt-get install -y \
    ros-noetic-ros-base

# Install torch2trt
WORKDIR /root
RUN git clone https://github.com/NVIDIA-AI-IOT/torch2trt.git
WORKDIR /root/torch2trt
RUN python3 setup.py install 
RUN python3 setup.py install --plugins

# Install trt_pose
WORKDIR /root
RUN git clone https://github.com/NVIDIA-AI-IOT/trt_pose.git 
WORKDIR /root/trt_pose
RUN python3 setup.py install 


