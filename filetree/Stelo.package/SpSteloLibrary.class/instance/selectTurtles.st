private
selectTurtles
	turtles size = 1
		ifTrue: [ self turtlesSelected: turtles first breedNo ]
		ifFalse: [ self selectTurtlesMenu openWithSpecAt: ActiveHand position ]