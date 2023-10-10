#!/bin/bash

modelarg=$1
output=$2

# Remove 'ntnx://' from the parameter
model=${modelarg//ntnx:\/\//}

python3 llm/download.py --model_name $model --output $output