microworld
multiplyBy: aNumber varNo: anInteger
	| src |
	src := variables realArrayAt: anInteger.
	src *= aNumber.