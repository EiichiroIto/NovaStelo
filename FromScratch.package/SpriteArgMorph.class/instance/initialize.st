initialize
initialize

	super initialize.
	self borderInset.
	self borderWidth: 1.
	self color: Color white.

	labelMorph := StringMorph new
		font: (ScratchTheme argFont);
		color: Color white.
	self addMorph: labelMorph.
	((labelMorph extent y) > 15)
		ifTrue: [ self extent: 20@((labelMorph extent y) + 3) ]
		ifFalse: [ self extent: 20@15 ].
	menuIconMorph := ImageMorph new form: DropDownMenuForm.
	self addMorphFront: menuIconMorph.

	morph := nil.
	self updateLabel.
