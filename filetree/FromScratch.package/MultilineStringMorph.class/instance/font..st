accessing
font: aFont

	font := aFont.
	renderer := StringMorph new font: aFont.
	lineHeight := renderer stringHeight: ScratchTranslator renderHintString, 'Ag'.
	self wordWrapAll.
