utilities
isArgSpec: aString
	"Answer true if the given string is an argument specification."

	^ ((aString size > 1) and: [aString first = $%])
