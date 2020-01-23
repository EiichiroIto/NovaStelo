observer ops
createPatch
	| count |
	count := self pop.
	world createPatch: count asInteger.