initialization
label: aString font: font

	label2 delete.
	label2
		contents: aString;
		font: font;
		color: (isOn ifTrue: [labelColorOn] ifFalse: [labelColorOff]).
	self addMorphFront: label2.
	self updateSize.
