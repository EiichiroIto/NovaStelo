private
turtlesSelected: anInteger
	self selectButton: buttonTurtles label asString.
	whenTurtlesSelectedDo cull: anInteger