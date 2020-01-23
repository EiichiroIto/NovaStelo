stelo funcs
addVariable: vno breed: bno
	^ self ffiCall: #(bool addVariable(int bno, int vno))