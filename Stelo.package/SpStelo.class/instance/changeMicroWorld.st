private
changeMicroWorld
	sworldMode = #SMicroWorld
		ifTrue: [ ^ self ].
	sworldMode := #SMicroWorld.
	self sworld: self newWorld