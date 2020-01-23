accessing
newNo
	| v |
	v := nextNo.
	nextNo := nextNo + 1.
	^ v