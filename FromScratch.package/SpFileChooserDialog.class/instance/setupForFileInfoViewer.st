initialization
setupForFileInfoViewer
	fileList whenFileSelectedBlock: [ self itemSelected ].
	fileInfo readOnly: true