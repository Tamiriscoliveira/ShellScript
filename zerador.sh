#!/bin/bash

i=$1

while test $i -gt 0
   do
     i=$((i-1))
     echo "contador: $i"
done
