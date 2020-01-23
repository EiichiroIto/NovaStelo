stelo funcs
setFloat: vno breed: bno id: tno value: value
	^ self ffiCall: #(void setFloat(int bno, int vno, int tno, float value))