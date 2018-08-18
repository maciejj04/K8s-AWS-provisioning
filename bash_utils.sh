
function checkArgs() {
	echo "Checking args..."

	count=$1
	if [[ $count -ne $(($#-1)) ]]; then
		echo "ERROR: Wrong nr of arguments for $0"
		exit 1
	fi
}