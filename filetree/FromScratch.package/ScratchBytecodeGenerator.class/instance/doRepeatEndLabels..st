control ops
doRepeatEndLabels: aCollection
	self appendSymbol: #dec.
	self appendSymbol: #jump withJump: aCollection first.
	self appendLabel: aCollection second.
	self appendSymbol: #drop.