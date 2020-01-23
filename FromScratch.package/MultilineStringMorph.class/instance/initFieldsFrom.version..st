object i/o
initFieldsFrom: anObjStream version: classVersion

	| fontSpec |
	super initFieldsFrom: anObjStream version: classVersion.

	fontSpec := anObjStream nextField.
	self font: (StrikeFont fontName: fontSpec first size: fontSpec second).

	self initFieldsNamed: #(
		textColor
		selectionColor
		lines
	) from: anObjStream