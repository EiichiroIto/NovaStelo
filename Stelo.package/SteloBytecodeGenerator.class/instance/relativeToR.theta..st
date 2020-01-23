patch ops
relativeToR: r theta: theta
	self appendValue: r.
	self appendValue: theta.
	self appendSymbol: #cos.
	self appendSymbol: #mul.
	self appendSymbol: #getX.
	self appendSymbol: #plus.
	self appendValue: r.
	self appendValue: theta.
	self appendSymbol: #sin.
	self appendSymbol: #mul.
	self appendSymbol: #getY.
	self appendSymbol: #plus.
	self appendSymbol: #patchAt.
	^ nil