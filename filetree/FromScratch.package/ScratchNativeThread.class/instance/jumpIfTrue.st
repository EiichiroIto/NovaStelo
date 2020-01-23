control ops
jumpIfTrue
	| address cond |
	address := self pop.
	cond := self pop.
	cond = 0
		ifFalse: [ pc := address ].