stelo funcs
setWordAll: vno breed: bno extArray: list size: size
	^ self ffiCall: #(void setWordAll(int bno, int vno, FFIExternalArray list, int size))