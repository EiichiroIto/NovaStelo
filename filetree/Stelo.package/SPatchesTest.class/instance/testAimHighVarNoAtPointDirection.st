tests-command
testAimHighVarNoAtPointDirection
	| ps v ret |
	ps := SPatches new.
	ps create: 5.
	v := ps addVariable: 'a'.
	"
	21 22 23 24 25
	16 17 18 19 20
	11 12 13 14 15
	 6  7  8  9 10
	 1  2  3  4  5
"
	ps var: v at: 18 put: 1.
	ps var: v at: 19 put: 2.
	ps var: v at: 14 put: 3.
	ret := ps aimHighVarNo: v atPoint: 0 @ 0 direction: 45.
	self assert: ret equals: -45.
	ps var: v at: 18 put: 4.
	ps var: v at: 19 put: 3.
	ps var: v at: 14 put: 2.
	ret := ps aimHighVarNo: v atPoint: 0 @ 0 direction: 45.
	self assert: ret equals: 45.
	ps var: v at: 18 put: 4.
	ps var: v at: 19 put: 5.
	ps var: v at: 14 put: 2.
	ret := ps aimHighVarNo: v atPoint: 0 @ 0 direction: 45.
	self assert: ret equals: 0.

	"
	21 22 23 24 25
	16 17 18 19 20
	11 12 13 14 15
	 6  7  8  9 10
	 1  2  3  4  5
"
	ps var: v at: 17 put: 1.
	ps var: v at: 18 put: 2.
	ps var: v at: 19 put: 3.
	ret := ps aimHighVarNo: v atPoint: 0 @ 0 direction: 90.
	self assert: ret equals: -45.
	ps var: v at: 16 put: 3.
	ps var: v at: 17 put: 3.
	ps var: v at: 18 put: 2.
	ps var: v at: 19 put: 1.
	ps var: v at: 20 put: 1.
	ret := ps aimHighVarNo: v atPoint: 0 @ 0 direction: 90.
	self assert: ret equals: 45