initialization
initializePresenters
	tableVars := self newTable.
	labelVars := self newLabel.
	buttonRefresh := self newButton.
	buttonDelete := self newButton.
	tableVars
		addColumn:
			(SpStringTableColumn
				title: 'Name'
				evaluated: [ :o | self getNameOf: o ]);
		addColumn:
			(SpStringTableColumn
				title: 'Value'
				evaluated: [ :o | self getValueOf: o ]).
	labelVars label: 'Variables'.
	buttonRefresh
		label: 'Refresh';
		icon: (self iconNamed: #refresh).
	buttonDelete
		label: 'Delete';
		icon: (self iconNamed: #delete).
	self focusOrder
		add: tableVars;
		add: buttonRefresh;
		add: buttonDelete