test
testClassNameFor
	| pv a b |
	pv := self newVarDef.
	a := pv add: 'a' className: #Array.
	b := pv add: 'b' className: #ByteArray.
	self assert: (pv classNameFor: 'a') equals: #Array.
	self assert: (pv classNameFor: 'b') equals: #ByteArray.