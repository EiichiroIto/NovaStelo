*FromScratch
initFieldsFrom: anObjStream version: classVersion

	| fontSpec |
	super initFieldsFrom: anObjStream version: classVersion.
	fontSpec := anObjStream nextField.
	fontSpec ifNotNil: [
		font := StrikeFont fontName: fontSpec first size: fontSpec second].

	self initFieldsNamed: #(
		emphasis
		contents
	) from: anObjStream.
