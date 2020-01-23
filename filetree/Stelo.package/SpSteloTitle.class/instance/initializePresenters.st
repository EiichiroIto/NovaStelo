initialization
initializePresenters
	labelName := self newLabel.
	toolBar := self newToolBar.
	labelName label: 'new project'.
	self setupButtons.
	self focusOrder add: toolBar