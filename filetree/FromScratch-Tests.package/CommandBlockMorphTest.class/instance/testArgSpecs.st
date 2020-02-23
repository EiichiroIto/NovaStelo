test
testArgSpecs
	| b |
	b := self newBlock
		receiver: self newScript;
		yourself.
	b commandSpec: 'abc %s def %n ghi %m'.
	self assertCollection: b argSpecs equals: #('%s' '%n' '%m')