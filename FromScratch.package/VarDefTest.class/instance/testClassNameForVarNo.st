test
testClassNameForVarNo
	| pv a b |
	pv := self newVarDef.
	a := pv add: 'a' className: #Array.
	b := pv add: 'b' className: #ByteArray.
	self assert: (pv classNameForVarNo: a) equals: #Array.
	self assert: (pv classNameForVarNo: b) equals: #ByteArray.