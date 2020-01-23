private
chooseExistingFileType: aSymbol title: aString extension: ext
	| dialog d |
	dialog := SpFileChooserDialog new.
	dialog
		extension: ext;
		title: aString;
		type: aSymbol.
	d := dialog openModalWithSpec: #chooseExistingFileSpec.
	d isCancelled
		ifTrue: [ ^ nil ].
	^ dialog selectedFile