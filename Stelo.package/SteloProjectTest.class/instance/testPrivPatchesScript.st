test
testPrivPatchesScript
	| app proj s |
	proj := self newProject.
	app := self newApp.
	proj application: app.
	self assert: proj privPatchesScript isNil.
	s := proj newPatchesScript.
	proj privPatchesScript: s.
	proj addScript: s.
	self assert: proj privPatchesScript equals: s.
	self assert: (proj scriptOf: 2) equals: s