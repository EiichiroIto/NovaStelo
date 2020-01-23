test
testList
	| a ret |
	a := self newArray: #Array.
	a list: 3 set: #(10 20 30).
	ret := (a list: 1).
	self assertCollection: ret equals: #().
	self assertCollection: (a list: 2) equals: #().
	self assertCollection: (a list: 3) equals: #(10 20 30)