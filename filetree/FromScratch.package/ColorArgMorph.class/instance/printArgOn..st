other
printArgOn: aStream
	"Print this argument morph on the given stream."

	aStream nextPutAll: 'c[',
		(self hexFor: color red),
		(self hexFor: color green),
		(self hexFor: color blue),
		']'.
