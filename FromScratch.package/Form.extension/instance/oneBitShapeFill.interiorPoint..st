*FromScratch
oneBitShapeFill: aColor interiorPoint: aPoint

	depth > 1 ifTrue: [self error: 'This call only meaningful for 1-bit forms'].

	(self findShapeAroundSeedBlock: [:f | f pixelValueAt: aPoint put: 1])
		displayOn: self
		at: 0@0
		clippingBox: self boundingBox
		rule: Form under
		fillColor: aColor.
