stelo funcs
getFloatAll: vno breed: bno
	^ self ffiCall: #(ExternalAddress getFloatAll(int bno, int vno))