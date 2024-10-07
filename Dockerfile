FROM dustynv/l4t-pytorch:r35.3.1

LABEL maintainer filip.zoric@fer.hr 

RUN apt-get install curl 

# Build and install OpenCV
RUN git clone git@github.com:opencv/opencv.git
RUN mkdir build
WORKDIR /opencv/build
RUN cmake .. 
RUN cmake --build . 
RUN make install 

# Install ROS
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
RUN apt-get update 
RUN apt-get install ros-noetic-desktop 

# Install trt_pose, torch2trt
COPY ./setup.sh /root/setup.sh
WORKDIR /root
RUN bash -c "./setup.sh"
