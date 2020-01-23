private
nsumInner
	| list sum |
	list := indexesDict at: #inner.
	list
		do: [ :index | 
			sum := neighbor + index sum: [ :i | src at: i ].
			dst at: index put: sum ].