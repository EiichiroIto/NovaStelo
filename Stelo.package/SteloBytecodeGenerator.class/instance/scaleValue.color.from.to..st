color ops
scaleValue: v color: c from: f to: t
	self appendValue: v.
	self appendValue: c.
	self appendValue: f.
	self appendValue: t.
	self appendSymbol: #scaleColorFromTo.