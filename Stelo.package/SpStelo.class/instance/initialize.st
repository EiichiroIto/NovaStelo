initialization
initialize
	super initialize.
	lastMSec := nil.
	lastTicks := 0.
	sworldMode := self defaultSWorldMode.
	presenter sworldMode: sworldMode