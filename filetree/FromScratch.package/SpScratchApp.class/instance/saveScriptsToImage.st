menu actions
saveScriptsToImage
	"Take a snapshot of all scripts for a sprite and save as a GIF file"

	| fName saveForm pngExt |
	pngExt := 'png'.
	saveForm := presenter scriptForm.
	saveForm ifNil: [ ^ self ].
	fName := self
		chooseNewFileDefault: ''
		extension: pngExt
		title: 'Save script snapshot' localized
		type: #scriptsSnapshot.
	fName ifNil: [ ^ self ].
	fName := fName withExtension: pngExt.
	saveForm writePNGFileNamed: fName pathString