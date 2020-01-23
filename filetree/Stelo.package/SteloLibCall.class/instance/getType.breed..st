stelo funcs
getType: vno breed: bno
	^ self ffiCall: #(int getType(int bno, int vno))