test
testCoerceArgs
	| b ret |
	b := self newBlock
		receiver: self newScript;
		yourself.
	b selector: #abc:def:.
	b commandSpec: 'abc %n def %s ghi %n'.
	ret := b coerceArgs: #('20.0' 'abc' 30).
	self assertCollection: ret equals: #(20 'abc' 30).
	b selector: #setVar:to:.
	ret := b coerceArgs: #('20.0' 'abc' 30).
	self assertCollection: ret equals: #('20.0' 'abc' 30)