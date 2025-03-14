#!/bin/bash

set -e

# 安装依赖
apt update && apt install -y make build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncursesw5-dev \
    xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

# 下载 Python 源码
PYTHON_VERSION=3.13.2
wget https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz

# 解压源码
tar xzf Python-$PYTHON_VERSION.tgz
cd Python-$PYTHON_VERSION

# 编译和安装
./configure
make -j$(nproc)
sudo make altinstall

# 配置 Python 软链接
sudo rm -rf /usr/bin/python3
sudo ln -s /usr/local/bin/python3.13 /usr/bin/python3
sudo ln -sf /usr/local/bin/python3.13 /usr/bin/python

# 配置 pip 软链接
sudo ln -sf /usr/local/bin/pip3.13 /usr/bin/pip

# 验证安装
python3 --version
pip --version