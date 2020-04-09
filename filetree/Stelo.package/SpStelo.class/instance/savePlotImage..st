menu actions
savePlotImage: aPlotter
	"Take a snapshot of all scripts for a sprite and save as a GIF file"

	| fName saveForm pngExt |
	pngExt := self imageExtension.
	saveForm := presenter formFrom: aPlotter extent: 400 @ 400.
	saveForm ifNil: [ ^ self ].
	fName := self
		chooseNewFileDefault: ''
		extension: pngExt
		title: 'Save Plots Snapshot'
		type: #scriptsSnapshot.
	fName ifNil: [ ^ self ].
	fName := fName withExtension: pngExt.
	saveForm writePNGFileNamed: fName pathString