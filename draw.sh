#!/bin/sh

# file 입력
MEMBERS=member
DAY=$(<day.txt)
FILENAME=$DAY"주차"
RANGE=Range
RANGE_FILE=./$RANGE/$FILENAME
LOG=log

echo "We will try to make file to manage for $FILENAME"
touch ./$LOG/$FILENAME

while :
do
	VALUE=`gshuf -n 4 $MEMBERS`
	array=($VALUE)

	idx=0
	boolean=0

	while read content; do
		if [ ${array[$idx]} == $content ]
		then
			echo "The values are the same. So, we will try to shuffle the values."
			boolean=1
			break
		fi
		idx=$(($idx+1))
	done < $MEMBERS

	if [ $boolean -eq 0 ];
	then
		break;
	fi
done

echo ${array[0]} > $MEMBERS
echo ${array[1]} >> $MEMBERS
echo ${array[2]} >> $MEMBERS
echo ${array[3]} >> $MEMBERS

paste -d ":" $RANGE_FILE $MEMBERS | while IFS=":" read -r deepdive name; do
    echo "$name : $deepdive"
    echo "$name : $deepdive" >> ./LOG/$FILENAME
done

DAY=`expr $DAY + 1`
echo $DAY > day.txt

echo "Complete!! :))"
