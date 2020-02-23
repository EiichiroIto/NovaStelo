tests-accessing
testClassNameFor
	| pv |
	pv := STurtleVarDef new.
	self assert: (pv classNameFor: 'color') equals: #ByteArray.
	self assert: (pv classNameFor: 'flag') equals: #ByteArray.
	self assert: (pv classNameFor: 'x') equals: #FloatArray.
	self assert: (pv classNameFor: 'y') equals: #FloatArray.
	self assert: (pv classNameFor: 'heading') equals: #FloatArray