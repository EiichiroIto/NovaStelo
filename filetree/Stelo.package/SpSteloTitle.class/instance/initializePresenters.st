initialization
initializePresenters
	labelName := self newLabel.
	labelName label: 'new project'.
	clearTurtleButton := self newButton.
	clearPatchesButton := self newButton.
	setupButton := self newButton.
	stopButton := self newButton.
	stepButton := self newButton.
	eventButton := self newButton.
	loopSlowButton := self newButton.
	loopButton := self newButton.
	self setupButtons.
	self focusOrder
		add: clearTurtleButton;
		add: clearPatchesButton;
		add: setupButton;
		add: stopButton;
		add: stepButton;
		add: eventButton;
		add: loopSlowButton;
		add: loopButton