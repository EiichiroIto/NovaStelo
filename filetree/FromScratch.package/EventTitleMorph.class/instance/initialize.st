initialization
initialize

	super initialize.
	self borderInset.
	self borderWidth: 1.
	self color: Color brown.

	menuIconMorph := ImageMorph new form: DropDownMenuForm.
	self addMorphFront: menuIconMorph.

	labelMorph := StringMorph new
		font: (ScratchTheme argFont);
		color: Color white.
	self addMorph: labelMorph.
	self eventName: ''.
