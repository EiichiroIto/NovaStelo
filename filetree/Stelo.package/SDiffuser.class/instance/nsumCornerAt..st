private
nsumCornerAt: aSymbol
	| list index sum |
	list := indexesDict at: aSymbol.
	sum := cornerIndexes
		sum: [ :i | 
			index := list at: i.
			src at: index ].
	index := list at: 5.
	dst at: index put: sum.