object i/o
storeFieldsOn: anObjStream

	super storeFieldsOn: anObjStream.

	anObjStream putField: {font familyName. font pointSize}.  "font spec"
	self storeFieldsNamed: #(
		textColor
		selectionColor
		lines
	) on: anObjStream.

