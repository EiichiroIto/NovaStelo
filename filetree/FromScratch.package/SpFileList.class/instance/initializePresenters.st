initialization
initializePresenters
	listHierarchy := self newDropList
		startWithoutSelection.
	listEntries := self newList
		beSingleSelection;
		activateOnDoubleClick.
	buttonParent := self newButton
		icon: (self iconNamed: #up).
	buttonNew := self newButton
		icon: (self iconNamed: #add).
	self directory: FileSystem workingDirectory.
	self focusOrder
		add: listHierarchy;
		add: buttonParent;
		add: buttonNew;
		add: listEntries