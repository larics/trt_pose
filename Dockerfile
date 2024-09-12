FROM dustynv/l4t-pytorch:r35.3.1

LABEL maintainer=filip.zoric@fer.hr

WORKDIR /root/

RUN git clone https://github.com/larics/trt_pose.git

CMD ["bash"]
