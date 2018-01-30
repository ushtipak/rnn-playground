#!/bin/bash

echo -n "> bootstrap rnn ... "
curl -s https://raw.githubusercontent.com/ushtipak/rnn-bootstrap/master/setup-rnn.sh | bash >/dev/null 2>&1
rm /opt/rnn-karpathy/data/tinyshakespeare/ -rf && echo done

echo -n "> fetch occupations from wikipedia ... "
amazon-linux-extras install python3 >/dev/null 2>&1
curl -s https://raw.githubusercontent.com/ushtipak/rnn-playground/master/fetch-occupations.py | python3 > /opt/rnn-karpathy/data/input.txt && echo done

echo -n "> train a model ... "
cd /opt/rnn-karpathy
th train.lua -data_dir /opt/rnn-karpathy/data -rnn_size 128 -batch_size 2 -num_layers 3 -dropout 0.6 -gpuid -1 >/dev/null 2>&1 && echo done

echo "> generate occupations ..."
sudo th sample.lua cv/$(ls cv/ -1t | head -1) -gpuid -1

echo "all done \o/"
