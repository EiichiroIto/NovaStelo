test
testSubTable
	| b d |
	b := self newGenerator.
	self assert: b subTable isNil.
	d := Dictionary new.
	b subTable: d.
	self assert: b subTable equals: d.