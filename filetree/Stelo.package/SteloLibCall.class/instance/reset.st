stelo funcs
reset
	self ffiCall: #(void reset()).
	self primitiveFailed.