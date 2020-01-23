test
testInvLiterals
	| a x y |
	a := self newArray.
	a := a forceTo: 4 paddingWith: ''.
	a stringAt: 1 put: 'abc'.
	a stringAt: 2 put: 'def'.
	a stringAt: 3 put: 'abc'.
	a stringAt: 4 put: 'ghi'.
	x := a privInvLiterals copy.
	a privInvLiterals: nil.
	y := a invLiterals.
	self assert: x equals: y.
	self assert: a privInvLiterals equals: y