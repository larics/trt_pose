# Setup 

## Manual installation
How to setup trt_pose for Jetson Orin Nx. 

1. Check Jetpack version. 
```
sudo apt-cache show nvidia-jetpack
```
2. Install corresponding pytorch following this [link](https://forums.developer.nvidia.com/t/pytorch-for-jetson/72048) 
```
sudo apt-get install python3-pip libopenblas-dev
pip install <wheel-name>
```
or after installing python run: 
```
pip3 install torch torchvision
```
3. After installing torch and torchvision, install [torch_2_trt](https://github.com/NVIDIA-AI-IOT/torch2trt)
```
git clone git@github.com:NVIDIA-AI-IOT/torch2trt.git
pip3 install packaging
<set CUDA_HOME var to the location of your cuda installation [export CUDA_HOME=/usr/lib/aarch64-linux-gnu/]>
python3 setup.py install --plugins
```
** NOT SUCCESSFUL --> FOR NOW ** 

## jetson-containers 

Download [jetson-containers](https://github.com/dusty-nv/jetson-containers/tree/master). 

Run exemplary jetson container
```
jetson-containers run $(autotag l4t-pytorch)
```
It doesn't assign container name (that's wanted) so it is needed to check name of the container: 
enter container and then install `torch2trt` from github repo (as stated above). 

After running jetson-containers (remove `rm` flag in the command), 
build `trt_pose` and build `torch2trt`. 

First install `torch2trt` as follows: 
```
git clone https://github.com/NVIDIA-AI-IOT/torch2trt.git
cd torch2trt
python3 setup.py install 
python3 setup.py install --plugins
```
After installing torch2trt install `trt_pose`: 

```
git clone https://github.com/NVIDIA-AI-IOT/trt_pose.git 
python3 setup.py install 
```
Install `notebook` and `tqdm`
```
pip install notebook tqdm pycocotools
```
Follow `README.md` from `trt_pose` to see where to put weights of an NN.  

### Hacks/Solutions

Problem with `import trt_pose.plugins` can be solved using following [link](https://github.com/NVIDIA-AI-IOT/trt_pose/issues/2). 

# TODO: 
- [x] Explore [jetson containers](https://github.com/dusty-nv/jetson-containers)
- [x] Run contaier from `jetson-containers`
- [ ] Check `trt_pose` demo in ROS node
- [ ] Add `trt_pose` to ROS node 
- [ ] Test ROS 2 humble container
- [ ] Add `trt_hand_pose`
- [x] Create Dockerfile that's used to setup correct env for HPE on Jetson --> Not possible 
- [x] Create script that set ups fast from jetson-containers base image `setup.sh`

