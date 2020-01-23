private
writeScript: aScript
	| plotter size |
	aScript isObserver
		ifFalse: [ ^ self ].
	plotter := aScript plotter.
	size := plotter pens size.
	plotter data
		do: [ :each | 
			(each forceTo: size paddingWith: nil)
				do: [ :each2 | each2 ifNotNil: [ stream nextPutAll: each2 asString ] ]
				separatedBy: [ stream nextPut: $, ].
			stream crlf ]