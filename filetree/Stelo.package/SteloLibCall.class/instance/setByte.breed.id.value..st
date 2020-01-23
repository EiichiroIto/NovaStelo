stelo funcs
setByte: vno breed: bno id: tno value: value
	^ self ffiCall: #(void setByte(int bno, int vno, int tno, byte value))