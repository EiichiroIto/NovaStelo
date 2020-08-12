menu actions
savePlotImage: aPlotter
	| fName saveForm pngExt |
	pngExt := 'png'.
	saveForm := self formFrom: aPlotter extent: 400 @ 400.
	saveForm ifNil: [ ^ self ].
	fName := self application
		chooseNewFileDefault: ''
		extension: pngExt
		title: 'Save Plots Snapshot' localized
		type: #scriptsSnapshot.
	fName ifNil: [ ^ self ].
	fName := fName withExtension: pngExt.
	saveForm writePNGFileNamed: fName pathString