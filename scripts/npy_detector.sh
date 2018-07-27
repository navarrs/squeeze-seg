#!/bin/bash

export CKPT="./data/SqueezeSeg/model.ckpt-23000"
export INPATH="./data/test/g/g_vlp64_v1/*"
export GPUID=0
export RATE=10

if [ $# -eq 0 ]
then
      echo "Usage: ./scripts/train.sh [options]"
      echo " "
      echo "options:"
      echo "-h, --help              Show brief help"
      echo "-gpu                    Set gpu (id | n (cpu))"
      echo "-ckpt                   Model checkpoint"
      echo "-inpath                 Path to input point clouds"
      echo "-rate                   Publishing rate"
  	  exit 0
fi

while test $# -gt 0; do
  case "$1" in
    -h|--help)
      echo "Usage: ./scripts/train.sh [options]"
      echo " "
      echo "options:"
      echo "-h, --help              Show brief help"
      echo "-gpu                    Set gpu (id | n (cpu))"
      echo "-ckpt                   Model checkpoint"
      echo "-inpath                 Path to input point clouds"
	  echo "-rate                   Publishing rate"
  	  exit 0
      ;;
    -gpu)
      export GPUID="$2"
      shift
      shift
      ;;
    -ckpt)
      export CKPT="$2"
      shift
      shift
      ;;
    -inpath)
      export INPATH="$2"
      shift
      shift
      ;;
    -rate)
	  export RATE="$2"
	  shift
      shift
      ;;
    *)
      break
      ;;
  esac
done
   
# bash ./scripts/killall.sh
bash ./scripts/quickstart.sh -rviz_cfg ./rviz/default.rviz

python ./src/visualize.py \
	--checkpoint=$CKPT \
	--input_path=$INPATH \
	--gpu=$GPUID \
    --rate=$RATE
