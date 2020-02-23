test
testGetId
	| g |
	g := self newGenerator.
	g getId.
	self assertCollection: g code equals: { #getId . #stop }.