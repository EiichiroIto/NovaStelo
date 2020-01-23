button actions
addTurtles
	| script |
	script := project addNewTurtleScript.
	sworld addBreed: script breed.
	^ script