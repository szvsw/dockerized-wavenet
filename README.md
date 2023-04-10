# Docker Container for Wavenet

Place your audio files into corpus

```
docker build tf-wavenet .
docker run -it --gpus all tf-wavenet -p6006:6006
```

```
docker-compose up -d --build wavenet
```

You are now inside your container

```
cd tensorflow-wavenet
python train.py --data_dir=../corpus/ --log_dir=../logdir/train --sample_size=16000
```