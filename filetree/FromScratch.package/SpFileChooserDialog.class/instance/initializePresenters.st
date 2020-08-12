initialization
initializePresenters
	shortcuts := self instantiate: SpShortcutButtons.
	fileList := self instantiate: SpFileList.
	textFilename := self instantiate: SpLabelledTextInput.
	fileInfo := self instantiate: SpFileInfo.
	textFilename
		label: 'Filename:';
		acceptOnCR: true.
	self focusOrder
		add: fileList;
		add: textFilename