private
setupReservedVarNames
	self
		addReserved: 'color'
		varNo: self class colorVarNo
		className: #ByteArray.
	self
		addReserved: 'flag'
		varNo: self class flagVarNo
		className: #ByteArray.
	self addReservedVariable: 'x' varNo: self class xVarNo.
	self addReservedVariable: 'y' varNo: self class yVarNo.
	self addReservedVariable: 'heading' varNo: self class headingVarNo.
	self setupVarNames