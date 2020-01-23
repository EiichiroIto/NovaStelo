private
documents
	Smalltalk os isWindows
		ifTrue: [ self windowsDocuments ifNotNil: [ :dir | ^ dir ] ].
	^ FileLocator documents asFileReference