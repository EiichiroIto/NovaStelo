private
literal: aString
	aString isNumberString
		ifTrue: [ ^ aString asNumber ].
	^ aString