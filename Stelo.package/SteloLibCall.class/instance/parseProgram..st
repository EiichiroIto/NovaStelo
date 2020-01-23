stelo funcs
parseProgram: aString
	self ffiCall: #(void parseProgram(String aString)).
	self primitiveFailed.