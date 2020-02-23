test
testNewNo
	| e |
	e := self newBaseId.
	self assert: e privNextNo equals: e class defaultUserNo.
	e newNo.
	self assert: e privNextNo equals: e class defaultUserNo + 1.
	e newNo.
	self assert: e privNextNo equals: e class defaultUserNo + 2.