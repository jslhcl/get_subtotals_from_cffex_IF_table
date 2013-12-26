#!/bin/awk -f

BEGIN { 
	FS="[<|>]"
	tblName=""
	dataTypeId=0
	rank=0
	vol0=0
	varVol0=0
	vol1=0
	varVol1=0
	vol2=0
	varVol2=0
}

/instrumentId/	{
	tblName=$3
	if (index(tblName, "TF") > 0)	#we want IF only
		exit
}

/dataTypeId/	{
	dataTypeId=$3
}

/rank/	{
	rank=$3
}

/volume/	{
	value=$3
	if (dataTypeId==0) 
		vol0 = vol0+value
	else if (dataTypeId==1) 
		vol1 = vol1+value
	else if (dataTypeId==2) 
		vol2 = vol2+value

	if (rank==20) {
		printf("%s:\n", tblName) >> ARGV[2]
		if (dataTypeId==0) {
			printf("volume=%d\n", vol0) >> ARGV[2]
			vol0 = 0
		}
		else if (dataTypeId==1) {
			printf("volume=%d\n", vol1) >> ARGV[2]
			vol1 = 0
		}
		else if (dataTypeId==2) {
			printf("volume=%d\n", vol2) >> ARGV[2]
			vol2 = 0
		}
	}
}

/varVolume/	{
	value=$3
	if (dataTypeId==0) 
		varVol0 = varVol0+value
	else if (dataTypeId==1) 
		varVol1 = varVol1+value
	else if (dataTypeId==2) 
		varVol2 = varVol2+value

	if (rank==20) {
		if (dataTypeId==0) {
			printf("varVolume=%d\n", varVol0) >> ARGV[2]
			varVol0 = 0
		}
		else if (dataTypeId==1) {
			printf("varVolume=%d\n", varVol1) >> ARGV[2]
			varVol1 = 0
		}
		else if (dataTypeId==2) {
			printf("varVolume=%d\n", varVol2) >> ARGV[2]
			varVol2 = 0
		}
	}
}
