button actions
deleteTurtles: anInteger
	| script |
	script := project scriptOf: anInteger.
	project deleteScript: script.
	sworld deleteBreed: script breed.
	presenter updateDisplay