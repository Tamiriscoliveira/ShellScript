#!/bin/bash


for numero in um dois tres quatro cinco; do echo "contando: $numero"; done

echo "#####################################################################################"
echo usando  for com seq para listagem
for numero in $(seq 10); do echo "contando: $numero"; done

echo "######################################################################################"

i=0

while test  $i -le 10
do
	i=$((i+1))
	echo "Contando: $i"
done
