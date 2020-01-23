turtle  ops
isPenDown
	self appendValue: 0.
	self getVar: STurtleVarDef flagVarNo.
	self appendValue: 1 << STurtleVarDef penDownFlagNo.
	self appendSymbol: #and.
	self appendSymbol: #less.
	^ nil