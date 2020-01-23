turtle  ops
changeXposBy: aNumber
	self appendSymbol: #getX.
	self appendValue: aNumber.
	self appendSymbol: #plus.
	self appendSymbol: #setX