turtle  ops
changeYposBy: aNumber
	self appendSymbol: #getY.
	self appendValue: aNumber.
	self appendSymbol: #plus.
	self appendSymbol: #setY