misc ops
directionTo: pno
	self appendValue: pno.
	self appendSymbol: #xyOf.
	self appendSymbol: #swap.
	self appendSymbol: #getX.
	self appendSymbol: #minus.
	self appendSymbol: #swap.
	self appendSymbol: #getY.
	self appendSymbol: #minus.
	self appendSymbol: #direction.
	^ nil