stelo funcs
setDefaultTurtle: bno x: x y: y
	self ffiCall: #(void setDefaultTurtleXY(int bno, float x, float y)).