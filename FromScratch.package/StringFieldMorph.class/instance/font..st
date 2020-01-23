accessing
font: aFont

	stringMorph font: aFont.
	stringMorph height: (stringMorph stringHeight: ScratchTranslator renderHintString).
	self height: stringMorph height + (2 * borderWidth) + heightPadding.
	insetY := (self height // 2) - borderWidth - (ScratchTranslator centerOffsetForButtonWithFont: aFont).
	insetY := insetY max: 1.
	self borderWidth: borderWidth.  "re-position string"
