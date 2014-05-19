#!/bin/bash
{
    sleep 5m
    kill $$
} &

while true
do
    date
    sleep 1
done
