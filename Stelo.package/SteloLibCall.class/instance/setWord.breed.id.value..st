stelo funcs
setWord: vno breed: bno id: tno value: value
	^ self ffiCall: #(void setWord(int bno, int vno, int tno, uint32 value))