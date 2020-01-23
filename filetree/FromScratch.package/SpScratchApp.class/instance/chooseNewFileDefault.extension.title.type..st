private
chooseNewFileDefault: filename extension: ext title: aString type: aSymbol
	| dialog d |
	dialog := SpFileChooserDialog new.
	dialog
		extension: ext;
		filename: filename;
		title: aString;
		type: aSymbol.
	d := dialog openModalWithSpec: #chooseNewFileSpec.
	d isCancelled
		ifTrue: [ ^ nil ].
	^ dialog filename