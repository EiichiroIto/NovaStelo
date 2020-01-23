microworld
breedsAtPoint: aPoint
	| list x y |
	x := aPoint x truncated.
	y := aPoint y truncated.
	list := OrderedCollection new.
	self
		livingOnesDo: [ :index | 
			((self xAt: index) truncated = x and: [ (self yAt: index) truncated = y ])
				ifTrue: [ list add: index ] ].
	^ list