stelo funcs
isRunning
	^ self ffiCall: #(bool isRunning())