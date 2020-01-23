test
testAddNewTurtleScript
	| app proj s |
	proj := self newProject.
	app := self newApp.
	proj application: app.
	proj privObserverScript: proj newObserverScript.
	s := proj addNewTurtleScript.
	self assert: (s isKindOf: TurtlesScript).
	self assert: s objName isString.
	self assert: (proj scripts includes: s).
	self assert: (s breed isKindOf: STurtles)