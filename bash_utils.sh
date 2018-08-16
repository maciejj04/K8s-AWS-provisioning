
function checkArgs() {
	echo "Checking args..."
	argsCount=$#

	for x in $(seq 1 1 $#); do
		echo $x
		if [ "$x" = "" ]; then
			echo "dupa"
			exit 1
		fi
	done
	
}

function randomAlphanumericClusterResourceIdentifier() {
	cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 7 | head -n 1
}

checkArgs dupa a a

#res=$(randomAlphanumericClusterResourceIdentifier)
#echo $res
