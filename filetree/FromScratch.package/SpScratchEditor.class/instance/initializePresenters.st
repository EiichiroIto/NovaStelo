initialization
initializePresenters
	labelName := self newLabel.
	labelStatus := self newLabel.
	notebook := self newNotebook.
	notebook addPage: self createEditorPage