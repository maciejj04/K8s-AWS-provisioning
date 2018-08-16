
function checkArgs() {
	echo "Checking args..."
	echo $0 $1 $2
	if [ "$1" = "" ] || [ "$2" = "" ] ; then
		echo "dupa"
		exit 1
	fi
}

function randomAlphanumericClusterResourceIdentifier() {
	cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 7 | head -n 1
}

#res=$(randomAlphanumericClusterResourceIdentifier)
#echo $res
