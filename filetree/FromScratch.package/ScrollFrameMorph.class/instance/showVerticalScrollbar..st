scrollbar visibility
showVerticalScrollbar: aBoolean
	"Show or hide my vertical scrollbar."

	aBoolean
		ifTrue: [
			self addMorph: vScrollbar.
			hScrollbar owner = self ifTrue: [self addMorph: cornerMorph]]
		ifFalse: [
			vScrollbar delete.
			cornerMorph delete].

	self extent: self extent.
