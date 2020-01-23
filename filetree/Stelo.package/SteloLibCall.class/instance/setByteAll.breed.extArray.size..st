stelo funcs
setByteAll: vno breed: bno extArray: list size: size
	^ self ffiCall: #(void setByteAll(int bno, int vno, FFIExternalArray list, int size))