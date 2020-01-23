tests-accessing
testResult
	| d |
	d := SDiffuser neighbor4.
	self assert: d result isNil.
	d privDst: 123.
	self assert: d result equals: 123.
	d privDst: 456.
	self assert: d result equals: 456.