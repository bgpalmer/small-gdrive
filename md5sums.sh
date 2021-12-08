#!/usr/bin/bash 

source '../Src/Bash/logging.sh'
script_logging_level="INFO"

function usage {
	echo "usage: md5sums.sh [-i, --input-directory] [-n --filename]";
}


while [ "" != "$1" ]; do
	case $1 in 
		-n | --filename)
			shift
			declare -r MD5SUMS=$1
			log "DEBUG" "Filename: $MD5SUMS"
			;;

		-i | --input-directory)
			shift
			declare -r DIRECTORY=$1
			log "DEBUG" "Directory: $DIRECTORY"
			;;

		-h | --help)
			usage
			exit 0
			;;

		*)
			usage
			exit 1
			;;
	esac
	shift
done


test -z $DIRECTORY	&&	{ log	"ERROR" 	"Hic Directory not supplied.";			exit 1; }
test -d $DIRECTORY 	||	{ log	"ERROR" 	"Hic Directory does not exist.";		exit 1; }

test -z $MD5SUMS	&&	{ log	"ERROR" 	"MD5 Sums filename not supplied.";		exit 1; }
test -f $MD5SUMS 	||	{ log	"ERROR" 	"MD5 Sums filename not supplied.";		exit 1; }

# remove the BOM
# rf. https://stackoverflow.com/questions/45240387/how-can-i-remove-the-bom-from-a-utf-8-file
sed -i $'1s/^\uFEFF//' $MD5SUMS

while read line
do 
	sum=$($line | cut -d ' ' -f 1,1)
	file=$($line | cut -d ' ' -f 2,2)

	if 
done < $MD5SUMS