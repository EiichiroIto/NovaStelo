test
testProject
	| d x y |
	d := self newDirectory.
	x := FileSystem workingDirectory.
	self assert: d project equals: x.
	x := FileLocator documents asFileReference.
	(x / '_xx_') isDirectory
		ifTrue: [ (x / '_xx_') delete ].
	d appName: '_xx_'.
	y := d project.
	self assert: y pathString equals: (x / '_xx_') pathString.
	self assert: (x / '_xx_') isDirectory.
	(x / '_xx_') delete