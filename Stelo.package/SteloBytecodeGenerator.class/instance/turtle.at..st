misc ops
turtle: bid at: pno
	self appendValue: pno.
	self appendValue: bid.
	self appendSymbol: #turtleAt.
	^ nil