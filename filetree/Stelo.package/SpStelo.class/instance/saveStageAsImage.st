menu actions
saveStageAsImage
	| fName saveForm pngExt |
	pngExt := self imageExtension.
	saveForm := presenter stageShotExtent: self class screenshotExtent.
	saveForm ifNil: [ ^ self ].
	fName := self
		chooseNewFileDefault: self projectName
		extension: pngExt
		title: 'Save Patches Snapshot'
		type: #scriptsSnapshot.
	fName ifNil: [ ^ self ].
	fName := fName withExtension: pngExt.
	saveForm writePNGFileNamed: fName pathString