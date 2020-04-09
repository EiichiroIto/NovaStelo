accessing
exportFrom: anApplication isBinary: aBoolean
	| project |
	project := anApplication project.
	stream := WriteStream
		on:
			(aBoolean
				ifTrue: [ ByteArray new ]
				ifFalse: [ '' ]).
	self writeHeader: project.
	self writeScripts: project scripts.
	self writeFooter: project.
	^ stream contents