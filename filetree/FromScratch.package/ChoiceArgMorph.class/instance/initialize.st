initialization
initialize
	super initialize.
	self borderInset.
	self borderWidth: 1.
	self color: Color brown.
	labelMorph := StringMorph new
		font: ScratchTranslator argFont;
		color: Color white.
	self addMorph: labelMorph.
	menuIconMorph := ImageMorph new form: DropDownMenuForm.
	self addMorphFront: menuIconMorph.
	self choice: #a