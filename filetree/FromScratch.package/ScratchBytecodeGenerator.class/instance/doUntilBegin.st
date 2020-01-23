control ops
doUntilBegin
	| id |
	id := labelId newNo.
	self appendLabel: id.
	^ id