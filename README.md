# Docker Container for WaveNet

This repo will allow you to get up and running with the @ibab's [tensorflow-wavenet](https://github.com/ibab/tensorflow-wavenet) repository with minimal headaches.  While that repository is the canonical open source implementation of WaveNet, it is also over 6 years old at this point and can put you through the ringer trying to get your development environment set up. As long as you are on a machinie with an Nvidia GPU, this repo will help get you up and running in minutes.


## Requirements

First, head over to Docker and install [Docker Desktop](https://docker.com/get-started).


## Getting Started with the Docker Container
Next, clone this repo:

```sh
git clone https://github.com/szvsw/dockerized-wavenet.git
```

Place your audio files into the `corpus` directory within this repo.

Then, build the service:

```sh
docker-compose up -d --build wavenet
```

Then, print out the name of the currently running containers:

```sh
docker ps
```

You should see something like `dockerized-wavenet-wavenet-1` (some of the hyphens may be replaced with underscores depending on your machine).

Then, enter into the container:

```sh
docker exec -it <container-name-from-prev-step> /bin/bash
```

You are now inside your container!

You can check that the graphics card has been found by running the following command:

```sh
nvidia-smi
```

Inside of the container, the following directories are setup for you:

```
- /usr/src/
    - logdir/
    - corpus/
    - tensorflow-wavenet/
```

`logdir` and `corpus` are automatically mapped to the corresponding folders in this repo's directory on your host machine - updating files on your host machine in those folders will automatically be transported into your container and vice versa.

Once your audio files are in the `corpus` folder, you are ready to train.  Inside of your container, navigate to the `tensorflow-wavenet` directory and get learnin'!

## Training

```
cd tensorflow-wavenet
python train.py --data_dir=../corpus/ --log_dir=../logdir/train --sample_size=16000
```

You can use `python train.py --help` to see more options available.  Refer to the [ibab/tensorflow-wavenet](http://github.com/ibab/tensorflow-wavenet) repo for more documentation.

## Monitoring

You can also launch Tensorboard to monitor your training.  Exec into your container from a separate terminal window:

```sh
docker exec -it <container-name> /bin/bash
```
And then within the container, navigate to the directory where your logs are stored and launch Tensorboard:

```sh
cd /path/to/your/logdir
tensorboard --logdir=.
```

Then, on your host machine, use a browser to navigate to `http://localhost:6006` (the docker-compose file has automatically mapped the port for you) and you will see Tensorboard loading!

## Generating

When you are ready to generate audio after you have stopped training, `exec` into your container again, navigate to the `tensorflow-wavenet` directory, and then follow the instructions from the `ibab/tensorflow-wavenet` repo!

## Updating the Environment

If you would like to test out upgrading to different versions of Tensorflow, simply update the first line of the Dockerfile with the desired tag found on the Tensorflow Docker Hub [page](https://hub.docker.com/r/tensorflow/tensorflow/tags) and rebuild your services.  