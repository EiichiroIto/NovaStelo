*FromScratch
trailingDigits
	"Answer the trailing digits of a string such as 'foo123' If the string does not end in a digit, answer the empty string."
	"'foo123' trailingDigits"
	"'foo' trailingDigits"

	| i |
	i := self size.
	[(i > 0) and: [(self at: i) isDigit]] whileTrue: [i := i - 1].
	^ self copyFrom: i + 1 to: self size