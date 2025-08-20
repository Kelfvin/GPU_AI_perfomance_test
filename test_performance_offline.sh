#!/bin/bash

################################################################################################
# arg 1: a directory to model
# arg 2: testdataset path, which is a json file
# 
# -------------------example---------------------
# bash test_performance_offline.sh \
# /mnt/public/model/huggingface/Qwen3-8B dataset/ShareGPT_V3_unfiltered_cleaned_split.json
################################################################################################

if [ ! -x "$(command -v vllm)" ]; then
    echo "No vllm, Please Install!"
    exit 1
fi

if [ ! -x "$(command -v modelscope)" ]; then
    echo "No modelscope, Please Install!"
    exit 1
fi

TEST_MODEL=${1:-"models/Qwen3-8B"}
TEST_DATASET=${2:-"dataset/dataset/sonnet.txt"}
DATASET_NAME=${3:-"sonnet"}


if [ ! -d $TEST_MODEL ]; then
    modelscope download --model 'Qwen/Qwen3-8b' --local_dir $TEST_MODEL
fi

vllm bench throughput \
--backend vllm \
--model $TEST_MODEL \
--dataset-path $TEST_DATASET \
--dataset-name $DATASET_NAME \
--num-prompts 10