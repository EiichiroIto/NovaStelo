accessing
colors
	| colors x y c index |
	colors := self patches colors copy.
	self
		turtlesDo: [ :ts :id | 
			x := ts xAt: id.
			y := ts yAt: id.
			c := ts colorAt: id.
			index := self patches indexAtPoint: x @ y.
			colors at: index put: c ].
	^ colors