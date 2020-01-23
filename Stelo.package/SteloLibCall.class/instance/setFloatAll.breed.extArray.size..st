stelo funcs
setFloatAll: vno breed: bno extArray: list size: size
	^ self ffiCall: #(void setFloatAll(int bno, int vno, FFIExternalArray list, int size))