stelo funcs
getByte: vno breed: bno id: tno
	^ self ffiCall: #(byte getByte(int bno, int vno, int tno))