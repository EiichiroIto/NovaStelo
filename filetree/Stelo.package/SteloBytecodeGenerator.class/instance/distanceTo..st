misc ops
distanceTo: pno
	self appendValue: pno.
	self appendSymbol: #xyOf.
	self appendSymbol: #swap.
	self appendSymbol: #getX.
	self appendSymbol: #minus.
	self appendSymbol: #dup.
	self appendSymbol: #mul.
	self appendSymbol: #swap.
	self appendSymbol: #getY.
	self appendSymbol: #minus.
	self appendSymbol: #dup.
	self appendSymbol: #mul.
	self appendSymbol: #plus.
	self appendSymbol: #sqrt.
	^ nil