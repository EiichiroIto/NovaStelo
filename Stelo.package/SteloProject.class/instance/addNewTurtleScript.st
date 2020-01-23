accessing
addNewTurtleScript
	| breed script |
	breed := self observer newTurtle.
	script := self newTurtlesScript
		breed: breed;
		yourself.
	self
		addScript: script;
		assignUniqueObjNameTo: script.
	^ script