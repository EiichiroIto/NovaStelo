scrollbar visibility
showHorizontalScrollbar: aBoolean
	"Show or hide my horizontal scrollbar."

	aBoolean = (hScrollbar owner = self) ifTrue: [^ self].

	aBoolean
		ifTrue: [self addMorph: hScrollbar]
		ifFalse: [hScrollbar delete].

	self extent: self extent.
