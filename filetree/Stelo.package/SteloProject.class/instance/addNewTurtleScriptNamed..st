accessing
addNewTurtleScriptNamed: aString
	| breed script |
	breed := self observer newTurtle.
	script := self newTurtlesScript
		breed: breed;
		objName: aString;
		yourself.
	self addScript: script.
	^ script