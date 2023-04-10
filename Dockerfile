FROM tensorflow/tensorflow:1.2.0-gpu-py3
RUN apt-get update -y && \ 
    apt-get install -y \
    build-essential \
    software-properties-common \
    libedit-dev \
    llvm-8 \
    llvm-8-dev \
    libffi-dev \
    libsndfile1-dev \
    git \
    wget
ENV LLVM_CONFIG=/usr/bin/llvm-config-8

RUN pip install librosa==0.5.0 resampy==0.2.0 && pip uninstall scikit-learn -y && pip uninstall sklearn -y

WORKDIR /usr/src

RUN mkdir ./corpus

RUN mkdir ./logdir

RUN mkdir ./logdir/train
RUN mkdir ./logdir/generate
 
RUN git clone https://github.com/ibab/tensorflow-wavenet && \
    cd tensorflow-wavenet && \
    pip install -r requirements_gpu.txt

CMD [ "/bin/bash" ]