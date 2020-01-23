test
testProjectFor
	| d x y |
	d := self newDirectory.
	x := FileSystem workingDirectory.
	self assert: (d projectFor: nil) equals: x.
	x := FileLocator documents asFileReference.
	(x / '_xx_') isDirectory
		ifTrue: [ (x / '_xx_') delete ].
	y := d projectFor: '_xx_'.
	self assert: y pathString equals: (x / '_xx_') pathString.
	self assert: (x / '_xx_') isDirectory.
	(x / '_xx_') delete