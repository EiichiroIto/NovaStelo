processes
updateInfo
	| msec ticks fps info |
	self updateStatus.
	msec := Time millisecondClockValue.
	ticks := sworld ticks.
	lastMSec
		ifNotNil: [ fps := ((ticks - lastTicks) * 1000 / (msec - lastMSec)) truncated.
			info := String new writeStream
				in: [ :stream | 
					stream
						nextPutAll: 'ticks=';
						nextPutAll: ticks truncated asString;
						nextPutAll: ' (';
						nextPutAll: fps asString;
						nextPutAll: 'fps)';
						nextPutAll: ', ';
						nextPutAll: (sworld countAliveOf: SBreedId turtleBreedNo) asString;
						nextPutAll: ' turtles'.
					stream contents ].
			presenter info: info ].
	lastMSec := msec.
	lastTicks := ticks