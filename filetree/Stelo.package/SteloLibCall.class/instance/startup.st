stelo funcs
startup
	self ffiCall: #(void startup()).
	self primitiveFailed.