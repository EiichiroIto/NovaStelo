private
diffuseInner: anInteger
	| use distributes size data |
	size := neighbor size.
	(indexesDict at: #inner)
		do: [ :index | 
			data := src at: index.
			use := data / 100.0 * anInteger.
			distributes := use / size.
			dst at: index put: ((dst at: index) + data - use).
			neighbor + index
				do: [ :dstIndex | dst at: dstIndex put: ((dst at: dstIndex) + distributes) ] ].