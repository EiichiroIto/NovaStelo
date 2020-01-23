test
testUpdateCache
	| p |
	p := self newPlotter.
	self assert: p privCache isNil.
	p updateCache.
	self assert: p privCache isCollection