private
deleteTurtles
	turtles size = 1
		ifTrue: [ self inform: 'Can''t delete all turtles' ]
		ifFalse: [ self deleteTurtlesMenu openWithSpecAt: ActiveHand position ]