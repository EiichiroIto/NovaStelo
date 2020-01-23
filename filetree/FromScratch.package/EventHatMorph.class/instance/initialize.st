initialization
initialize
	| label |
	super initialize.
	self removeAllMorphs.
	label := StringMorph
		contents: 'when I receive'
		font: ScratchTheme labelFont.
	label color: Color white.
	self addMorphBack: label.
	scriptNameMorph := EventTitleMorph new.
	self addMorphBack: scriptNameMorph