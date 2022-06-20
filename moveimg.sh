#!/bin/bash

for i in $(cat images.txt); do
    echo "Moving $i"
    cp $i assets/images/1x/
done