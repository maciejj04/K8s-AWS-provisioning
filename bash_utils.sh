
function checkArgs() {
	echo "Checking args..."

	count=$1
	if [[ $count -ne $(($#-1)) ]]; then
		echo "ERROR: Wrong nr of arguments for $0"
	fi
	
}

function randomAlphanumericClusterResourceIdentifier() {
	cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 7 | head -n 1
}

checkArgs 4 dupa a a 

#res=$(randomAlphanumericClusterResourceIdentifier)
#echo $res
