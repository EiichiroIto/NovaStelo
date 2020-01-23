stelo funcs
clearBreed: anInteger
	^ self ffiCall: #(void clearBreed(int anInteger))