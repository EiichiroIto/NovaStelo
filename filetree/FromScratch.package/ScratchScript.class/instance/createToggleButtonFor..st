blocks
createToggleButtonFor: block
	| toggleButton |
	toggleButton := ToggleButton
		onForm: (ScratchTheme formAt: #watcherButtonPressed)
		offForm: (ScratchTheme formAt: #watcherButton).
	toggleButton
		target: self;
		actionSelector: #toggleWatcher:for:;
		arguments:
			{toggleButton.
			block};
		borderWidth: 0;
		setProperty: #balloonText toValue: 'View on stage' localized.
	self useVariableWatcher
		ifTrue: [ self updateWatcher: toggleButton for: block ].
	^ toggleButton