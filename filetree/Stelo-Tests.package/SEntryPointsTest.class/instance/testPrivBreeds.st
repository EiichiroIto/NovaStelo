tests-private
testPrivBreeds
	| c |
	c := SEntryPoints new.
	self assert: c privBreeds isDictionary.
	self assert: c privBreeds isEmpty.