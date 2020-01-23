stelo funcs
addEntryPoint: address eventNo: eno breedNo: bno
	^ self ffiCall: #(bool addEntryPoint(int eno, int bno, int address))