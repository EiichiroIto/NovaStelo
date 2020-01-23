turtle  ops
turn: aNumber
	self appendValue: aNumber.
	self getVar: STurtleVarDef headingVarNo.
	self appendSymbol: #plus.
	self appendSymbol: #setHeading.