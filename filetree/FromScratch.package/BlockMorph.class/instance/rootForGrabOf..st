dropping/grabbing
rootForGrabOf: aMorph
	"Allow myself to be extracted."

	^ (owner notNil and: [ owner isBlockPalette ])
		ifTrue: [ super rootForGrabOf: aMorph ]
		ifFalse: [ self ]