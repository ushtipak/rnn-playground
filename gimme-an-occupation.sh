#!/bin/bash

echo -n "> bootstrap rnn ... "
curl -s https://raw.githubusercontent.com/ushtipak/rnn-bootstrap/master/setup-rnn.sh | bash >/dev/null 2>&1
rm /opt/rnn-karpathy/data/tinyshakespeare/ -rf && echo done

echo -n "> fetch occupations from wikipedia ... "
amazon-linux-extras install python3
curl -s https://raw.githubusercontent.com/ushtipak/rnn-playground/master/fetch-occupations.py | python3 > /opt/rnn-karpathy/data/input.txt && echo done

echo -n "> train a model ... "
th train.lua -data_dir /opt/rnn-karpathy/data -rnn_size 64 -batch_size 20 -num_layers 2 -dropout 0.4 -gpuid -1 >/dev/null 2>&1 && echo done

