control ops
jumpIfFalse
	| address cond |
	address := self pop.
	cond := self pop.
	cond = 0
		ifTrue: [ pc := address ].