private
turtlesDeleted: anInteger
	application deleteTurtles: anInteger.
	self
		updateTurtles;
		currentTarget: application turtlesScripts first