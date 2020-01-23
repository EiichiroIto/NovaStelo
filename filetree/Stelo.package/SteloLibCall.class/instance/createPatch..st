stelo funcs
createPatch: anInteger
	self ffiCall: #(void createPatch(int anInteger)).
	self primitiveFailed