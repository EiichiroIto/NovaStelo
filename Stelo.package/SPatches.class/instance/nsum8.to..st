microworld
nsum8: anInteger1 to: anInteger2
	| src dst |
	src := variables realArrayAt: anInteger1.
	dst := variables realArrayAt: anInteger2.
	diffuser nsum: src dst: dst order: order neighborSize: 8.