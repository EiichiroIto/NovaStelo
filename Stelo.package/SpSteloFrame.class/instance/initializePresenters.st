initialization
initializePresenters
	logo := self newImage.
	buttonSave := self newButton.
	buttonOpen := self newButton.
	menu := self newMenuBar.
	viewerPane := self instantiate: SpSteloViewer.
	editorPane := self instantiate: SpSteloEditor.
	titlePane := self instantiate: SpSteloTitle.
	stageFrame := self instantiate: SpSteloStage.
	libraryPane := self instantiate: SpSteloLibrary.
	self setupTopPane.
	self setupTitlePane.
	self focusOrder
		add: editorPane