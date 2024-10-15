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
    ros-noetic-ros-base \
    ros-noetic-camera-info-manager \
    ros-noetic-image-transport

# Install torch2trt
WORKDIR /root
RUN git clone https://github.com/NVIDIA-AI-IOT/torch2trt.git
WORKDIR /root/torch2trt
RUN python3 setup.py install 
RUN python3 setup.py install --plugins

# Install trt_pose
WORKDIR /root
RUN git clone https://github.com/larics/trt_pose.git 
WORKDIR /root/trt_pose
RUN python3 setup.py install 
RUN cp /root/trt_pose/build/lib.linux-aarch64-cpython-38/trt_pose/plugins.cpython-38-aarch64-linux-gnu.so /root/trt_pose/trt_pose/

# Install jupyter notebook - DEV
RUN pip install notebook tqdm pycocotools

# Build catkin_ws wth hpe_ros_msgs
WORKDIR /root
RUN apt-get install -y \
    python3-catkin-tools 
RUN mkdir -p /catkin_ws/src
WORKDIR /root/catkin_ws/src
RUN git clone https://github.com/fzoric8/hpe_ros_msgs.git 
WORKDIR /root/catkin_ws
RUN bash -c "source /opt/ros/noetic/setup.bash; catkin build"

# Build hpe_ros_pkg
WORKDIR /root/catkin_ws/src 
RUN git clone https://github.com/larics/hpe_ros_package.git 
RUN git clone https://github.com/fzoric/usb_cam.git
RUN bash -c "source /opt/ros/noetic/setup.bash; source /root/catkin_ws/devel/setup.bash; catkin build" 
RUN echo "source /opt/ros/noetic/setup.bash" >> /root/.bashrc
RUN echo "source /root/catkin_ws/devel/setup.bash"

CMD ["bash"] 
