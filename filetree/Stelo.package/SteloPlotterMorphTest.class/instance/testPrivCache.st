test
testPrivCache
	| p |
	p := self newPlotter.
	self assert: p privCache isNil.
	p privCache: #(1 2 3).
	self assertCollection: p privCache equals: #(1 2 3)