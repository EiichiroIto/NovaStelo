test
testIdOf
	| d x |
	d := self newArray.
	x := d idOf: 'abc'.
	self assert: x equals: 1.
	self assert: (d privLiterals at: x) equals: 'abc'.
	x := d idOf: 'def'.
	self assert: x equals: 2.
	self assert: (d privLiterals at: x) equals: 'def'.
	x := d idOf: 'abc'.
	self assert: x equals: 1.
	self assert: (d privLiterals at: x) equals: 'abc'