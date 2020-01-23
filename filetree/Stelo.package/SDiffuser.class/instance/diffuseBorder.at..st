private
diffuseBorder: anInteger at: aSymbol
	| srcIndex dstIndex data use distributes size list |
	list := indexesDict at: aSymbol.
	size := neighbor size.
	rows + 2 to: list size - rows - 1 do: [ :i | 
		srcIndex := list at: i.
		data := src at: srcIndex.
		use := data / 100.0 * anInteger.
		distributes := use / size.
		dst at: srcIndex put: (dst at: srcIndex) + data - use.
		neighbor + i
			do: [ :i2 | 
				dstIndex := list at: i2.
				dst at: dstIndex put: (dst at: dstIndex) + distributes ] ].