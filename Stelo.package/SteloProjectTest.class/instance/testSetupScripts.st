test
testSetupScripts
	| app proj s |
	proj := self newProject.
	app := self newApp.
	app installNewProject: proj.
	proj setupScripts.
	s := proj scriptOf: 1.
	self assert: (s isKindOf: ObserverScript).
	s := proj scriptOf: 2.
	self assert: (s isKindOf: PatchesScript).
	s := proj scriptOf: 3.
	self assert: (s isKindOf: TurtlesScript)