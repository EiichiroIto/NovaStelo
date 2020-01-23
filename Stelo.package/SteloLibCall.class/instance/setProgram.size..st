stelo funcs
setProgram: list size: size
	self ffiCall: #(void setProgram(FFIExternalArray list, int size))