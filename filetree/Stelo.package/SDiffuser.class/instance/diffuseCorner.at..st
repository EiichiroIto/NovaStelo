private
diffuseCorner: anInteger at: aSymbol
	| index data use distributes list |
	list := indexesDict at: aSymbol.
	index := list at: 5.
	data := src at: index.
	use := data / 100.0 * anInteger.
	distributes := use / cornerIndexes size.
	dst at: index put: (dst at: index) + data - use.
	cornerIndexes
		do: [ :i | 
			index := list at: i.
			dst at: index put: (dst at: index) + distributes ].