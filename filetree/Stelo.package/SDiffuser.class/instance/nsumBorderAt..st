private
nsumBorderAt: aSymbol
	| list index index2 sum |
	list := indexesDict at: aSymbol.
	rows + 2 to: list size - rows - 1 do: [ :i | 
		index := list at: i.
		sum := neighbor + i
			sum: [ :i2 | 
				index2 := list at: i2.
				src at: index2 ].
		dst at: index put: sum ].