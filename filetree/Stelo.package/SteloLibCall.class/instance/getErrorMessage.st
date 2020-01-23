stelo funcs
getErrorMessage
	^ self ffiCall: #(String getError())