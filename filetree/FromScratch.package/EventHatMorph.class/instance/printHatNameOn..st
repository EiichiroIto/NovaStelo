other
printHatNameOn: aStream
	"Append a human-readable string for this hat block's name to the given stream."

	| evtName |
	evtName := self eventName.
	evtName = 'Scratch-StartClicked'
		ifTrue: [aStream nextPutAll: 'when green flag clicked']
		ifFalse: [aStream nextPutAll: 'when I receive "', evtName, '"'].
	aStream cr.

