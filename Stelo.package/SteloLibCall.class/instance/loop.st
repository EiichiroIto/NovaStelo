stelo funcs
loop
	self ffiCall: #(void loop()).
	self primitiveFailed.