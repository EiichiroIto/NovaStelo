accessing
string: anInteger at: id put: aString
	id = 0
		ifTrue: [ ^ self ].
	(self varAt: anInteger asInteger) stringAt: id put: aString