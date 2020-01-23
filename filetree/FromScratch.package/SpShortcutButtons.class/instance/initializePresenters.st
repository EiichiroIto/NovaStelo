initialization
initializePresenters
	buttonComputer := self newButton label: 'Computer'.
	buttonUser := self newButton label: 'User'.
	buttonDesktop := self newButton label: 'Desktop'.
	buttonExamples := self newButton label: 'Examples'.
	buttonProjects := self newButton label: 'My Projects'.
	self focusOrder
		add: buttonComputer;
		add: buttonUser;
		add: buttonDesktop;
		add: buttonExamples;
		add: buttonProjects