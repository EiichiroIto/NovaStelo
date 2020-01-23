arithmetic ops
is: a between: x and: y
	self lessEqual: x than: a.
	self lessEqual: a than: y.
	self appendSymbol: #and.
	^ nil