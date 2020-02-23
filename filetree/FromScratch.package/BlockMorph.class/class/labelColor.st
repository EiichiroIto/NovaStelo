accessing
labelColor
	^ LabelColor ifNil: [ LabelColor := ScratchTheme labelOffColor ]