test
testUserDefinedVarNos
	| e |
	e := self newBaseId.
	self assertCollection: e userDefinedVarNos equals: #().
	e newNo.
	self assertCollection: e userDefinedVarNos equals: #(1).
	e newNo.
	self assertCollection: e userDefinedVarNos equals: #(1 2).