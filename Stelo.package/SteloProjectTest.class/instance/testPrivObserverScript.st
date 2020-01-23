test
testPrivObserverScript
	| app proj s |
	proj := self newProject.
	app := self newApp.
	proj application: app.
	self assert: proj privObserverScript isNil.
	s := proj newObserverScript.
	proj privObserverScript: s.
	proj addScript: s.
	self assert: proj privObserverScript equals: s.
	self assert: (proj scriptOf: 1) equals: s