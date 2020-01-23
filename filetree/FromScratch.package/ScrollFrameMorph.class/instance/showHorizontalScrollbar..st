scrollbar visibility
showHorizontalScrollbar: aBoolean
	"Show or hide my horizontal scrollbar."

	aBoolean
		ifTrue: [
			self addMorph: hScrollbar.
			vScrollbar owner = self ifTrue: [self addMorph: cornerMorph]]
		ifFalse: [
			hScrollbar delete.
			cornerMorph delete].

	self extent: self extent.
