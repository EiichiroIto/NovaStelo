stelo funcs
patchIndexAtX: x y: y
	^ self ffiCall: #(int patchIndex(float x, float y))