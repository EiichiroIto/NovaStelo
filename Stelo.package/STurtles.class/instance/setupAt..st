microworld
setupAt: index
	self colorAt: index put: self defaultColor.
	self aliveAt: index put: true.
	self xAt: index put: self defaultPosition x.
	self yAt: index put: self defaultPosition y.
	self headingAt: index put: 360 atRandom - 1.0.
	self penDownAt: index put: false