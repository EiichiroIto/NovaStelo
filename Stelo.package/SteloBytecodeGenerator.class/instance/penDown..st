turtle  ops
penDown: aBoolean
	self appendValue: STurtleVarDef flagVarNo.
	self getVar: STurtleVarDef flagVarNo.
	self appendValue: 1 << STurtleVarDef penDownFlagNo.
	aBoolean
		ifTrue: [ self appendSymbol: #or ]
		ifFalse: [ self appendSymbol: #inv.
			self appendSymbol: #and ].
	self appendSymbol: #setVarTo