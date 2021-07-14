#!/bin/bash


printf "Sharps or flats? [sharps/flats]: "

read circle_dir 

echo ""

CATEGORIES=("Maggiore")
case $circle_dir in
	("sharps")
		NOTES=("Do" "Sol" "Re" "La" "Mi" "Si" "Fa♯" "Do♯")
		;;
	("flats")
		NOTES=("Do" "Fa" "Si♭" "Mi♭" "La♭" "Re♭" "Sol♭" "Do♭")
		;;
esac

TOTAL_T=0
COUNTER=1
TMP_NOTES=("${NOTES[@]}")
while :
do
	echo "5..."
	sleep 1
	echo "4..."
	sleep 1
	echo "3..."
	sleep 1
	echo "2..."
	sleep 1
	echo "1..."
	sleep 1
	echo ""

	# If all keys have been used, start over
	if [ ${#TMP_NOTES[@]} -eq 0 ]
	then
		echo "Circle completed! Starting over"
		echo ""
		TMP_NOTES=("${NOTES[@]}")
	fi

	START_S=$(date +%s)
	START_NS=$(date +%s%N)
	
	# Choose random key
	CUR_KEY="${TMP_NOTES[$RANDOM % ${#TMP_NOTES[@]}]}"
	echo "CUR_KEY=$CUR_KEY"
	# Remove current key
	echo "TMP_NOTES=\"${TMP_NOTES[@]}\""

	delete=( "$CUR_KEY" )

	for target in "${delete[@]}"; do
		for i in "${!TMP_NOTES[@]}"; do
			if [[ ${TMP_NOTES[i]} = $target ]]; then
				unset 'TMP_NOTES[i]'
			fi
		done
	done

	for i in "${!TMP_NOTES[@]}"; do
		new_array+=( "${TMP_NOTES[i]}" )
	done
	array=("${new_array[@]}")
	unset new_array

	echo "TMP_NOTES=\"${TMP_NOTES[@]}\""
	# Choose random category
	CUR_CATEG="${CATEGORIES[$RANDOM % ${#CATEGORIES[@]}]}"
	echo "${CUR_KEY} ${CUR_CATEG}"
	echo ""
	read -n 1 -s

	END_S=$(date +%s)
	END_NS=$(date +%s%N)

	# Convert in ms...
	ELAPSED_NS=$((($END_NS-$START_NS)/1000000))
	# Compute seconda part of the string
	ELAPSED_S=$(($END_S-$START_S))

	# Approximate total time in seconds
	TOTAL_T=$(($TOTAL_T+$ELAPSED_S))
	# Approximate average time in seconds
	AVG_T=$(($TOTAL_T/$COUNTER))
	# Format time in ms of current iteration
	FORM_ELAP_T="${ELAPSED_S}.$(echo "$ELAPSED_NS" | tail -c -3)"

	echo "Elapsed time: ${FORM_ELAP_T}s"
	echo "Average time: ${AVG_T}s/scale"
	COUNTER=$(($COUNTER+1))
	echo ""
done
