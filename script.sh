#!/bin/bash

START=$(date +%s)

while [[ $(($(date +%s) - $START)) -ne 300 ]]
do
    #do something here
done

echo QUIT
