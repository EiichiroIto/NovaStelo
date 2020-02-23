test
testApplication
	| p app |
	p := self newProject.
	self assert: p application isNil.
	app := self newApp.
	p application: app.
	self assert: p application equals: app