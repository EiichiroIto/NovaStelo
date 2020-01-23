misc ops
randomFromTo
	| to from result |
	to := self pop.
	from := self pop.
	result := (from to: to) atRandom.
	self push: result.