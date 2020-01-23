tests-execution
testExecuteThreadBreedNoIndexIfTerminatedDo
	| w prg p f x addr |
	w := self newWorld.
	prg := SProgram new.
	p := w newProcess program: prg.
	w create: 3 turtles: 1.
	w var: STurtleVarDef colorVarNo breed: 3 at: 1 put: SColorList black.
	addr := prg nextAddress.
	prg addCode: {#pushShort. SColorList white. 0. #setColorTo. #stop}.
	f := false.
	p executeThread: addr breedNo: 3 index: 1 ifTerminatedDo: [ f := true ].
	x := w var: STurtleVarDef colorVarNo breed: 3 at: 1.
	self assert: x equals: SColorList white.
	self deny: f.
	addr := prg nextAddress.
	prg addCode: {#stopAll}.
	p executeThread: addr breedNo: 3 index: 1 ifTerminatedDo: [ f := true ].
	self assert: f.