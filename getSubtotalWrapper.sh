#!/bin/bash

for i in {0..1500}
do
	lstrDate=$(date -d "$i day ago" +%Y%m/%d)
	./getSubtotal.sh $lstrDate
done	
