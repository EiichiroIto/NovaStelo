scrollbar visibility
showVerticalScrollbar: aBoolean
	"Show or hide my vertical scrollbar."

	aBoolean = (vScrollbar owner = self) ifTrue: [^ self].

	aBoolean
		ifTrue: [self addMorph: vScrollbar]
		ifFalse: [vScrollbar delete].

	self extent: self extent.
