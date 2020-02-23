test
testOrganizeArgs
	| b |
	b := self newBlock
		receiver: self newTestScript;
		yourself.
	b commandSpec: 'abs %n'.
	b selector: #abs.
	self assertCollection: (b organizeArgs: #(1)) equals: #(1).
	b commandSpec: 'plus %n and %n'.
	b selector: #plus:and:.
	self assertCollection: (b organizeArgs: #(2 3)) equals: #(2 3).
	b commandSpec: 'plus %n and %n'.
	b selector: #plus:and:.
	b argPermutation: #(2 1).
	self assertCollection: (b organizeArgs: #(2 3)) equals: #(3 2).
	b commandSpec: '%n = %n'.
	b selector: #=.
	b argPermutation: #(2 1).
	self assertCollection: (b organizeArgs: #(2 3)) equals: #(2 3)