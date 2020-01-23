test
testAddTurtles
	| app proj ret |
	app := self newApp.
	proj := self newProject.
	app installNewProject: proj.
	self assert: proj scripts size equals: 3.
	self assert: app sworld privBreeds size equals: 3.
	ret := app addTurtles.
	self assert: ret breedNo equals: 4.
	self assert: proj scripts size equals: 4.
	self assert: app sworld privBreeds size equals: 4.
	self assert: (ret isKindOf: TurtlesScript).
	self assert: (proj scriptOf: 4) equals: ret.
	self assert: (app sworld breedOf: 4) equals: ret breed