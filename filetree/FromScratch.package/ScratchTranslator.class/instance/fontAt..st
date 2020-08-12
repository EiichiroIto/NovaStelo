accessing
fontAt: aString
	^ fonts at: aString ifAbsent: [ self defaultFont ]