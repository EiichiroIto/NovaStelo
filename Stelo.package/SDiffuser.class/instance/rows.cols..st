accessing
rows: anInteger1 cols: anInteger2
	rows := anInteger1.
	cols := anInteger2.
	self setupIndexes.
	self perform: setupSelector.