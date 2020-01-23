stelo funcs
getScreen
	^ self ffiCall: #(byte *getScreen())