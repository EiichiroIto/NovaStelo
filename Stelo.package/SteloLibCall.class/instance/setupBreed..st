stelo funcs
setupBreed: anInteger
	self ffiCall: #(void setupBreed(int anInteger))