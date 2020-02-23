private
turtlesDeleted: anInteger
	application deleteTurtles: anInteger.
	self
		updateTurtles;
		target: application turtlesScripts first