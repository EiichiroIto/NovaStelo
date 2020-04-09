test
testWriteScriptNames
	| ex proj |
	proj := self newProject.
	proj
		addScript:
			(self newScript
				objName: 'a';
				yourself);
		addScript:
			(self newScript
				objName: 'b';
				yourself).
	ex := self newExporter.
	ex privStream: '' writeStream.
	ex writeScriptNames: proj.
	self assert: ex privStream contents equals: '(a b)'