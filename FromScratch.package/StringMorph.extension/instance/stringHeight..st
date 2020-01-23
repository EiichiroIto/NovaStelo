*FromScratch
stringHeight: aString
	^ (font ifNil: [ TextStyle defaultFont ]) height ceiling