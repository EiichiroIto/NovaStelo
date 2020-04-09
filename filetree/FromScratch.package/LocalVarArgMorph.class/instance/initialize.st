initialization
initialize
	super initialize.
	self borderWidth: 1.
	self borderInset.
	self color: ScratchTheme blockArgColor.
	self extent: 25 @ 12.

	"To allow for editing in place."
	labelMorph := self newLabelMorph.
	self addMorph: labelMorph.
	iconMorph := self newIconMorph.
	self addMorphFront: iconMorph.
	iconMorph on: #mouseDown send: #iconMouseDown: to: self