test
testDoIfElse
	| w b t i |
	w := self newWorld.
	w create: 3 turtles: 2.
	w
		var: STurtleVarDef colorVarNo
		breed: 3
		at: 1
		put: 0.
	w
		var: STurtleVarDef colorVarNo
		breed: 3
		at: 2
		put: 0.
	b := self newGenerator.
	b appendValue: false.
	i := b doIfBegin: nil.
	b die.
	i := b doIfElse: i.
	b setVar: STurtleVarDef colorVarNo to: 15.
	b doIfEnd: i.
	self
		assert: (w var: STurtleVarDef colorVarNo breed: 3 at: 1)
		equals: 0.
	self assert: (w flag: STurtleVarDef aliveFlagNo breed: 3 at: 1).
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self
		assert: (w var: STurtleVarDef colorVarNo breed: 3 at: 1)
		equals: 15.
	self assert: (w flag: STurtleVarDef aliveFlagNo breed: 3 at: 1).
	b := self newGenerator.
	b appendValue: true.
	i := b doIfBegin: nil.
	b die.
	i := b doIfElse: i.
	b setVar: STurtleVarDef colorVarNo to: 15.
	b doIfEnd: i.
	self
		assert: (w var: STurtleVarDef colorVarNo breed: 3 at: 2)
		equals: 0.
	self assert: (w flag: STurtleVarDef aliveFlagNo breed: 3 at: 2).
	t := self newThread: w.
	t forBreedNo: 3 index: 2.
	t codes: b code.
	t execute: 1.
	self
		assert: (w var: STurtleVarDef colorVarNo breed: 3 at: 2)
		equals: 0.
	self deny: (w flag: STurtleVarDef aliveFlagNo breed: 3 at: 2)