tests-private
testPrivSWorld
	| w p |
	w := SMicroWorld new.
	p := SteloProcess new.
	self assert: p privSWorld isNil.
	p privSWorld: w.
	self assert: p privSWorld equals: w.