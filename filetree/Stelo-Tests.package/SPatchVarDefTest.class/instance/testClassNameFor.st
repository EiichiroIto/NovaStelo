tests-accessing
testClassNameFor
	| pv |
	pv := SPatchVarDef new.
	self assert: (pv classNameFor: 'color') equals: #ByteArray.
	self assert: (pv classNameFor: 'screen') equals: #ByteArray.
	self assert: (pv classNameFor: 'x') equals: #FloatArray.
	self assert: (pv classNameFor: 'y') equals: #FloatArray