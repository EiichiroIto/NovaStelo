private
writeHeader: aProject
	| plotter size |
	plotter := aProject application plotter.
	size := plotter pens size.
	plotter data
		do: [ :each | 
			(each forceTo: size paddingWith: nil)
				do: [ :each2 | each2 ifNotNil: [ stream nextPutAll: each2 asString ] ]
				separatedBy: [ stream nextPut: $, ].
			stream crlf ]