blocks
addGenericVariableBlocksTo: page y: startY
	| addButton deleteButton x y |
	addButton := ScratchTheme
		buttonLabel: 'Make a variable' localized
		selector: #addVariable:.
	deleteButton := ScratchTheme
		buttonLabel: 'Delete a variable' localized
		selector: #deleteVariable:.
	x := 13.
	page
		addMorph:
			(addButton
				target: self project application;
				arguments: {self};
				position: x @ startY).
	y := addButton bottom + 3.
	self varNames notEmpty
		ifTrue: [ page
				addMorph:
					(deleteButton
						target: self project application;
						arguments: {self};
						position: x @ y).
			y := deleteButton bottom + 10.
			y := self addVariableReportersTo: page x: x y: y.
			y := y + 12.
			y := self addGenericVariableBlocksTo: page x: x y: y ].
	^ y