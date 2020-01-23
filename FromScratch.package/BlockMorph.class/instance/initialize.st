initialization
initialize

	super initialize.
	blockLayoutNeeded := true.
	isSpecialForm := false.
	color := Color r: 0.4 g: 0.7 b: 0.8.
	oldColor := color.
	scratchProc := nil.
	hadError := false.
	lastLayoutTime := 0.
