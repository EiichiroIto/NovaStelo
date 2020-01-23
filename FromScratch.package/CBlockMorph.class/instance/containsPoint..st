geometry
containsPoint: aPoint

	cachedForm ifNil: [self updateCachedForm].
	^ (self fullBounds containsPoint: aPoint) and:
	  [(cachedForm isTransparentAt: aPoint - self fullBounds origin) not]
