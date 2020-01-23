acccessing
quotedString: aString
	^ (aString includes: Character space)
		ifTrue: [ '"' , aString , '"' ]
		ifFalse: [ aString ]