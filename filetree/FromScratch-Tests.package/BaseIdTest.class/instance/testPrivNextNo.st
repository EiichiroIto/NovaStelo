test
testPrivNextNo
	| e |
	e := self newBaseId.
	e privNextNo: 10.
	self assert: e privNextNo equals: 10.
	e privNextNo: 20.
	self assert: e privNextNo equals: 20.