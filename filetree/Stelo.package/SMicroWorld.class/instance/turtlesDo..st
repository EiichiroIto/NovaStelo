private
turtlesDo: aBlock
	self
		turtleBreedsDo: [ :ts | ts livingOnesDo: [ :index | aBlock value: ts value: index ] ].