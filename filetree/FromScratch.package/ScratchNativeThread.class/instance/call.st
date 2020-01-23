control ops
call
	| address |
	address := self pop.
	self push: pc.
	pc := address.