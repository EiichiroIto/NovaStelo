initialization
initialize
	super initialize.
	self color: ScratchTheme plotterPaneColor.
	self reset.
	self ensurePenExists: 1.
	lastUpdateTime := Time now