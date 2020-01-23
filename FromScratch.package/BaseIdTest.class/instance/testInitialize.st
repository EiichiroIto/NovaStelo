test
testInitialize
	| e |
	e := self newBaseId.
	self assert: e privNextNo equals: e class defaultUserNo.