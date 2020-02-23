test
testNumberArgFlags
	| b |
	b := self newBlock.
	b receiver: self newScript.
	b commandSpec: 'abc %s def %n ghi %e'.
	self assertCollection: b numberArgFlags equals: #(false true false)