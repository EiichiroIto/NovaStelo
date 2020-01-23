stelo funcs
stop
	self ffiCall: #(void stop()).
	self primitiveFailed.