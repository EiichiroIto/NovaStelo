initialization
initialize
	super initialize.
	self color: (Color h: 41 s: 0.85 v: 0.9).
	self extent: 92 @ 38.
	scriptOwner := nil.
	scriptNameMorph := StringMorph new
		contents: 'script';
		font: ScratchTranslator labelFont;
		color: Color white.
	self addMorph: scriptNameMorph