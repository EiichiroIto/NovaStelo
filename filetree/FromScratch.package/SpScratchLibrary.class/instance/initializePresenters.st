initialization
initializePresenters
	buttonMain := self newButton
		label: self defaultMainButtonName;
		icon: (self iconNamed: #page);
		yourself.
	buttonOther := self newButton
		label: self defaultOtherButtonName;
		icon: (self iconNamed: #page);
		yourself.
	buttonSelect := self newButton
		icon: (self iconNamed: #book);
		yourself.
	buttonAdd := self newButton
		icon: (self iconNamed: #add);
		yourself.
	buttonDelete := self newButton
		icon: (self iconNamed: #delete);
		yourself.
	self focusOrder
		add: buttonMain;
		add: buttonSelect;
		add: buttonAdd;
		add: buttonDelete