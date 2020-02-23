accessing
parse: aTopBlock initialIndent: anInteger
	indents at: 1 put: anInteger.
	position := anInteger.
	parser parseBlock: aTopBlock.
	^ stream contents