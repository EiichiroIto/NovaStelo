initialization
initializePresenters
	labelName := self newLabel.
	labelName label: 'new project'.
	toolBar := self newToolBar.
	self setupButtons.
	self focusOrder add: toolBar