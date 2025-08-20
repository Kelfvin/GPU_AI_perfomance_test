#!/bin/bash

# Test Dataset
TEST_DATASET="dataset/ShareGPT_V3_unfiltered_cleaned_split.json"
TEST_DATASET_URL="https://huggingface.co/datasets/anon8231489123/ShareGPT_Vicuna_unfiltered/resolve/main/ShareGPT_V3_unfiltered_cleaned_split.json"
if [ ! -f $TEST_DATASET ]; then
    wget $TEST_DATASET_URL -O "dataset/ShareGPT_V3_unfiltered_cleaned_split.json"
fi

if [ ! -x vllm ]; then
    echo "No vllm, Please Install!"
fi

TEST_MODEL="Qwen/Qwen3-8B"

vllm bench throughput \
  --backend vllm \
  --model $TEST_MODEL \
  --dataset-path $TEST_DATASET \
  --dataset-name sharegpt \
  --num-prompts 10

