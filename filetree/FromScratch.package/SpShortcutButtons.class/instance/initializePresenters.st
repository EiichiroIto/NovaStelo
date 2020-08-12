initialization
initializePresenters
	| blank |
	blank := Smalltalk ui iconNamed: #blank.
	buttonComputer := self newButton
		label: 'Computer' localized;
		icon: blank.
	buttonUser := self newButton
		label: 'User' localized;
		icon: blank.
	buttonDesktop := self newButton
		label: 'Desktop' localized;
		icon: blank.
	buttonExamples := self newButton
		label: 'Examples' localized;
		icon: blank.
	buttonProjects := self newButton
		label: 'My Projects' localized;
		icon: blank.
	self focusOrder
		add: buttonComputer;
		add: buttonUser;
		add: buttonDesktop;
		add: buttonExamples;
		add: buttonProjects