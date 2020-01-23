stelo funcs
getByteAll: vno breed: bno
	^ self ffiCall: #(byte *getByteAll(int bno, int vno))