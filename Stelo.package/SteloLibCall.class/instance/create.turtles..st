stelo funcs
create: bno turtles: size
	self ffiCall: #(void createTurtles(int bno, int size)).
	self primitiveFailed.