testing
isStopOrForever
	"True for stop or forever command blocks."

	^ self isStop or: [self isForever]
