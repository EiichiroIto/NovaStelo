accessing
buttonLabel: aString selector: aSymbolOrNil
	"Answer a big button with the given label."

	| button |
	button := ResizableToggleButton2 new
		offForm: (self formAt: #btn) onForm: (self formAt: #btnPressed);
		label: aString font: self buttonFont;
		actionSelector: aSymbolOrNil;
		labelColorOn: self labelOnColor
			labelColorOff: self labelOffColor
			labelColorOver: self labelOnColor.
	^ button