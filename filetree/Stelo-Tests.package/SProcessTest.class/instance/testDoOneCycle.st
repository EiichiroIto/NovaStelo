tests
testDoOneCycle
	| w p ret |
	w := self newWorld.
	w createPatch: 1.
	w create: 3 turtles: 1.
	p := w newProcess program: self sampleProgram3.
	p privRunningEvents: {4}.
	ret := p doOneCycle.
	self assert: ret not.