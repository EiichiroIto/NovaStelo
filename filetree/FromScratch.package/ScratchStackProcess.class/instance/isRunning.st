testing
isRunning
	"Answer true if I am still running, have not encountered an error, and don't refer to any deleted objects."

	^ stackFrame notNil and: [ errorFlag not ]