initialization
initialize

	super initialize.
	self cornerStyle: #square.
	isMomentary := false.
	toggleMode := true.
	isDisabled := false.
	isOn := isOver := false.
	alphaOn := false.
