color ops
stamp
	self getVar: STurtleVarDef xVarNo.
	self getVar: STurtleVarDef yVarNo.
	self appendSymbol: #patchAt.
	self getVar: STurtleVarDef colorVarNo.
	self appendSymbol: #setPatchColorTo.