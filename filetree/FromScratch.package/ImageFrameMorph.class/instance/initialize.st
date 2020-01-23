intialization
initialize

	super initialize.
	color := Color transparent.
	frameInFront := false.
	edgeCache := Array new: 5.
	self extent: 100@100.
