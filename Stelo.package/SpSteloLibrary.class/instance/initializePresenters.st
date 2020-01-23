initialization
initializePresenters
	buttonObserver := self newButton.
	buttonPatches := self newButton.
	buttonTurtles := self newButton.
	buttonAddTurtles := self newButton.
	buttonDeleteTurtles := self newButton.
	buttonObserver label: 'Observer'.
	turtles := nil.
	buttonPatches
		label: 'Patches';
		icon: (ScratchTheme formAt: #clearGraphicsButtonPressed).
	buttonTurtles
		label: 'Turtles';
		icon: (ScratchTheme formAt: #clearTurtlesButtonPressed).
	buttonAddTurtles icon: (self iconNamed: #add).
	buttonDeleteTurtles icon: (self iconNamed: #delete).
	self selectButton: 'Observer'.
	self focusOrder
		add: buttonObserver;
		add: buttonPatches;
		add: buttonTurtles;
		add: buttonAddTurtles;
		add: buttonDeleteTurtles