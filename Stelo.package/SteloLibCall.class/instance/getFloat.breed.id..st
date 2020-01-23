stelo funcs
getFloat: vno breed: bno id: tno
	^ self ffiCall: #(float getFloat(int bno, int vno, int tno))