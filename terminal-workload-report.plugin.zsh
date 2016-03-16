#!/bin/sh
function workreport() {
	SCRIPT_PATH=$( cd `dirname $0` && pwd )
	DATA_RECORD=$SCRIPT_PATH/data/record
	INSTANCE_TIME=$(date '+%Y-%m-%d %H:%M:%S')
	TOTAL_RECORD=$(sed -n '$=' ~/.zsh_history)

	# Colors
	NC='\033[0m'       # Text Reset
	Black='\033[0;30m'        # Black
	Red='\033[0;31m'          # Red
	Green='\033[0;32m'        # Green
	Yellow='\033[0;33m'       # Yellow
	Blue='\033[0;34m'         # Blue
	Purple='\033[0;35m'       # Purple
	Cyan='\033[0;36m'         # Cyan
	White='\033[0;37m'        # White

	if [[ ! -d $SCRIPT_PATH/data ]]; then
		mkdir $SCRIPT_PATH/data
		echo -e "LAST_CHECK_TIME=\"$INSTANCE_TIME\"\nTOTAL_HISTORY=$TOTAL_RECORD" > $DATA_RECORD
	else
		if [[ ! -f $DATA_RECORD ]]; then
			echo -e "LAST_CHECK_TIME=\"$INSTANCE_TIME\"\nTOTAL_HISTORY=$TOTAL_RECORD" > $DATA_RECORD
		elif [[ $(echo `cat $DATA_RECORD`)'x' == 'x' ]]; then
			# echo "Records file is null"
			echo -e "LAST_CHECK_TIME=\"$INSTANCE_TIME\"\nTOTAL_HISTORY=$TOTAL_RECORD" > $DATA_RECORD
		fi
	fi

	source $DATA_RECORD
	DAYIL_ADD=$[ $TOTAL_RECORD - $TOTAL_HISTORY ]

	echo "${Yellow}Terminal Workload Report${NC}"
	echo "${Blue}${LAST_CHECK_TIME}${NC} last checked time."
	echo "${Blue}${DAYIL_ADD}${NC} commands executed since last check."
	echo "${Blue}${TOTAL_RECORD}${NC} records in total."
	echo "${Yellow}Keep on working${NC}."


	CHECK_TIME=$(date '+%Y-%m-%d %H:%M:%S')
	RECORDS_DATA="LAST_CHECK_TIME=\"$CHECK_TIME\"\nTOTAL_HISTORY=$TOTAL_RECORD"
	echo -e $RECORDS_DATA > $DATA_RECORD

	unset INSTANCE_TIME
	unset HISTORY_NUM
	unset DAYIL_ADD
	unset TOTAL_RECORD
	unset TOTAL_HISTORY
	unset CHECK_TIME
	unset RECORDS_DATA
	unset SCRIPT_PATH
	unset DATA_RECORD

	unset Blue
	unset Black
	unset Red
	unset Green
	unset Yellow
	unset Purple
	unset Cyan
	unset White
	unset NC
}

