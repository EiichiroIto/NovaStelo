"
A SPatchesTest is a test class for testing the behavior of SPatches
"
Class {
	#name : #SPatchesTest,
	#superclass : #TestCase,
	#category : #'Stelo-Tests'
}

{ #category : #private }
SPatchesTest >> newBreed [
	^ SPatches new
]

{ #category : #'tests-command' }
SPatchesTest >> testAimHighVarNoAtPointDirection [
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
]

{ #category : #'tests-accessing' }
SPatchesTest >> testBreedNo [
	| o |
	o := SPatches new.
	self assert: o breedNo equals: SBreedId patchBreedNo.
	o breedNo: 123.
	self assert: o breedNo equals: SBreedId patchBreedNo.
]

{ #category : #'tests-command' }
SPatchesTest >> testClear [
	| ps cs v |
	ps := SPatches new.
	ps create: 3.
	cs := ps privVariables realArrayAt: SPatchVarDef colorVarNo.
	1 to: 9 do: [ :each | cs at: each put: each ].
	v := ps addVariable: 'a'.
	1 to: 9 do: [ :each | ps var: v at: each put: 5 ].
	self assertCollection: cs class equals: ByteArray.
	self assertCollection: cs asArray equals: #(1 2 3 4 5 6 7 8 9).
	self
		assertCollection: (ps privVariables realArrayAt: v)
		equals: #(5 5 5 5 5 5 5 5 5) asFloatArray.
	ps clear.
	self assertCollection: (ps privVariables realArrayAt: SPatchVarDef colorVarNo) equals: #(0 0 0 0 0 0 0 0 0) asByteArray.
	self
		assertCollection: (ps privVariables realArrayAt: v)
		equals: #(0 0 0 0 0 0 0 0 0) asFloatArray
]

{ #category : #'tests-accessing' }
SPatchesTest >> testColorAtPoint [
	| ps |
	ps := SPatches new.
	ps create: 3.
	ps privVariables setVar: SPatchVarDef colorVarNo toArray: #[2 0 0 0 1 0 0 3 4].
	self assert: (ps colorAtPoint: 0 @ 0) equals: 1.
	self assert: (ps colorAtPoint: -1 @ -1) equals: 2.
	self assert: (ps colorAtPoint: 0 @ 1) equals: 3.
	self assert: (ps colorAtPoint: 1 @ 1) equals: 4.
]

{ #category : #'tests-accessing' }
SPatchesTest >> testColorAtPointPut [
	| ps |
	ps := SPatches new.
	ps create: 3.
	self assertCollection: ps colors asArray equals: #(0 0 0 0 0 0 0 0 0).
	ps colorAtPoint: 0 @ 0 put: 1.
	ps colorAtPoint: -1 @ -1 put: 2.
	ps colorAtPoint: 0 @ 1 put: 3.
	ps colorAtPoint: 1 @ 1 put: 4.
	self assertCollection: ps colors asArray equals: #(2 0 0 0 1 0 0 3 4).
]

{ #category : #'tests-accessing' }
SPatchesTest >> testColorVariable [
	| ps |
	ps := SPatches new.
	ps create: 3.
	self assert: ps colors size equals: 9.
	self assert: (ps colors allSatisfy: [ :each | each = 0 ]).
]

{ #category : #'tests-accessing' }
SPatchesTest >> testCols [
	| ps |
	ps := SPatches new.
	self assert: ps cols equals: ps defaultOrder.
	ps create: 120.
	self assert: ps cols equals: 120.
]

{ #category : #'tests-command' }
SPatchesTest >> testCreate [
	| ps |
	ps := SPatches new.
	ps create: 4.
	self assert: (ps privVariables realArrayAt: 1) size equals: 16.
]

{ #category : #'tests-enumerating' }
SPatchesTest >> testDeadOnesDo [
	"do nothing"
]

{ #category : #'tests-private' }
SPatchesTest >> testDefaultOrder [
	| ps |
	ps := SPatches new.
	self assert: ps defaultOrder equals: 100.
]

{ #category : #'tests-command' }
SPatchesTest >> testDiffuse4VarNo [
	| ps v |
	ps := SPatches new.
	ps create: 3.
	v := ps addVariable: 'a'.
	ps var: v at: 5 put: 100.
	self
		assertCollection: (ps privVariables realArrayAt: v)
		equals: #(0 0 0 0 100 0 0 0 0) asFloatArray.
	ps diffuse4: 80 varNo: v.
	self
		assertCollection: (ps privVariables realArrayAt: v)
		equals: #(0 20 0 20 20 20 0 20 0) asFloatArray
]

{ #category : #'tests-command' }
SPatchesTest >> testDiffuse8VarNo [
	| ps v |
	ps := SPatches new.
	ps create: 3.
	v := ps addVariable: 'a'.
	ps var: v at: 5 put: 100.
	self
		assertCollection: (ps privVariables realArrayAt: v)
		equals: #(0 0 0 0 100 0 0 0 0) asFloatArray.
	ps diffuse8: 80 varNo: v.
	self
		assertCollection: (ps privVariables realArrayAt: v)
		equals: #(10 10 10 10 20 10 10 10 10) asFloatArray
]

{ #category : #'tests-accessing' }
SPatchesTest >> testExtent [
	| ps |
	ps := SPatches new.
	self assert: ps extent equals: (1 @ 1) * ps defaultOrder.
	ps create: 120.
	self assert: ps extent equals: 120 @ 120.
]

{ #category : #'tests-private' }
SPatchesTest >> testIndexAtColRow [
	| ps |
	ps := SPatches new.
	self assert: ps cols equals: 100.
	self assert: (ps indexAtCol: 1 row: 1) equals: 1.
	self assert: (ps indexAtCol: 1 row: 2) equals: 101.
	self assert: (ps indexAtCol: 100 row: 1) equals: 100.
	self assert: (ps indexAtCol: 2 row: 1) equals: 2.
	self assert: (ps indexAtCol: 100 row: 100) equals: 10000.
]

{ #category : #'tests-private' }
SPatchesTest >> testIndexAtPoint [
	| ps |
	ps := SPatches new.
	ps create: 5.
	self assert: ps cols equals: 5.
	self assert: ps rows equals: 5.
	self assert: (ps indexAtPoint: -2 @ -2) equals: 1.
	self assert: (ps indexAtPoint: -1.9 @ -2) equals: 1.
	self assert: (ps indexAtPoint: -1.1 @ -2) equals: 1.
	self assert: (ps indexAtPoint: -1 @ -2) equals: 2.
	self assert: (ps indexAtPoint: -0.9 @ -2) equals: 2.
	self assert: (ps indexAtPoint: -0.1 @ -2) equals: 2.
	self assert: (ps indexAtPoint: 0 @ -2) equals: 3.
	self assert: (ps indexAtPoint: 0.1 @ -2) equals: 3.
	self assert: (ps indexAtPoint: 0.9 @ -2) equals: 3.
	self assert: (ps indexAtPoint: 1 @ -2) equals: 4.
	self assert: (ps indexAtPoint: 2 @ -2) equals: 5.
	self assert: (ps indexAtPoint: 2.1 @ -2) equals: 5.
	self assert: (ps indexAtPoint: 2.9 @ -2) equals: 5.
	self assert: (ps indexAtPoint: -1 @ 1) equals: 17.
	self assert: (ps indexAtPoint: -0.9 @ 1) equals: 17.
	self assert: (ps indexAtPoint: 0 @ 0) equals: 13.
	self assert: (ps indexAtPoint: 0.1 @ 0) equals: 13.
	self assert: (ps indexAtPoint: 0.9 @ 0) equals: 13.
	self assert: (ps indexAtPoint: 2 @ 2) equals: 25.
	ps create: 6.
	self assert: ps cols equals: 6.
	self assert: ps rows equals: 6.
	self assert: (ps indexAtPoint: 0 @ 0) equals: 22.
	self assert: (ps indexAtPoint: -3 @ -3) equals: 1.
	self assert: (ps indexAtPoint: 2 @ 2) equals: 36.
	self assert: (ps indexAtPoint: -1 @ 1) equals: 27.
	ps create: 100.
	self assert: (ps indexAtPoint: -50 @ -50) equals: 1.
	self assert: (ps indexAtPoint: -49.5 @ -50) equals: 1.
	self assert: (ps indexAtPoint: -49 @ -50) equals: 2.
]

{ #category : #'tests-accessing' }
SPatchesTest >> testIndexAtXY [
	| ps |
	ps := SPatches new.
	ps create: 5.
	self assert: ps cols equals: 5.
	self assert: ps rows equals: 5.
	self assert: (ps indexAtX: -2 y: -2) equals: 1.
	self assert: (ps indexAtX: -1 y: -2) equals: 2.
	self assert: (ps indexAtX: 0 y: -2) equals: 3.
	self assert: (ps indexAtX: 1 y: -2) equals: 4.
	self assert: (ps indexAtX: 2 y: -2) equals: 5.
	self assert: (ps indexAtX: -3 y: -2) equals: 5.
	self assert: (ps indexAtX: -2 y: -1) equals: 6.
	self assert: (ps indexAtX: -2 y: 0) equals: 11.
	self assert: (ps indexAtX: -2 y: 1) equals: 16.
	self assert: (ps indexAtX: -2 y: 2) equals: 21.
	self assert: (ps indexAtX: -2 y: -3) equals: 21.
]

{ #category : #'tests-initialization' }
SPatchesTest >> testInitialize [
	| ps |
	ps := SPatches new.
	self assert: ps varId class equals: SPatchVarDef.
	self assert: ps privVariables class equals: Variables.
	self assert: ps size equals: 10000.
]

{ #category : #test }
SPatchesTest >> testIsPluginDiffuser [
	self testUsePluginDiffuser
]

{ #category : #'tests-enumerating' }
SPatchesTest >> testLivingOnesDo [
	| ps count |
	ps := SPatches new.
	ps create: 5.
	count := 0.
	ps livingOnesDo: [ :each | count := count + 1 ].
	self assert: count equals: 25.
]

{ #category : #'tests-command' }
SPatchesTest >> testMultiplyByVarNo [
	| ps v |
	ps := SPatches new.
	ps create: 3.
	v := ps addVariable: 'a'.
	ps var: v at: 3 put: 2.
	ps var: v at: 4 put: 3.
	ps var: v at: 5 put: 5.
	ps var: v at: 8 put: 11.
	self
		assertCollection: (ps privVariables realArrayAt: v)
		equals: #(0 0 2 3 5 0 0 11 0) asFloatArray.
	ps multiplyBy: 7 varNo: v.
	self
		assertCollection: (ps privVariables realArrayAt: v)
		equals: #(0 0 14 21 35 0 0 77 0) asFloatArray
]

{ #category : #'tests-accessing' }
SPatchesTest >> testNormalize [
	| ps r |
	ps := SPatches new.
	ps create: 7.
	-3 to: 3 do: [ :each | 
		r := ps normalize: each.
		self assert: r equals: each ].
	r := ps normalize: -4.
	self assert: r equals: 3.
	r := ps normalize: -5.
	self assert: r equals: 2.
	r := ps normalize: -7.
	self assert: r equals: 0.
	r := ps normalize: -10.
	self assert: r equals: -3.
	r := ps normalize: -11.
	self assert: r equals: 3.
	r := ps normalize: 4.
	self assert: r equals: -3.
	r := ps normalize: 5.
	self assert: r equals: -2.
	r := ps normalize: 7.
	self assert: r equals: 0.
	r := ps normalize: 10.
	self assert: r equals: 3.
	r := ps normalize: 11.
	self assert: r equals: -3.
	ps create: 8.
	-4 to: 3 do: [ :each | 
		r := ps normalize: each.
		self assert: r equals: each ].
	r := ps normalize: -5.
	self assert: r equals: 3.
	r := ps normalize: -8.
	self assert: r equals: 0.
	r := ps normalize: -12.
	self assert: r equals: -4.
	r := ps normalize: -13.
	self assert: r equals: 3.
	r := ps normalize: 4.
	self assert: r equals: -4.
	r := ps normalize: 8.
	self assert: r equals: 0.
	r := ps normalize: 11.
	self assert: r equals: 3.
	r := ps normalize: 12.
	self assert: r equals: -4.
	ps create: 100.
	r := ps normalize: 49.
	self assert: r equals: 49.
	r := ps normalize: 49.1.
	self assert: r equals: 49.1.
	r := ps normalize: -49.9.
	self assert: r closeTo: -49.9.
	r := ps normalize: -50.
	self assert: r equals: -50.
	r := ps normalize: -50.1.
	self assert: r equals: 49.9.
]

{ #category : #'tests-command' }
SPatchesTest >> testNsum4To [
	| ps v1 v2 |
	ps := SPatches new.
	ps create: 3.
	v1 := ps addVariable: 'a'.
	v2 := ps addVariable: 'b'.
	ps var: v1 at: 2 put: 2.
	ps var: v1 at: 7 put: 1.
	self
		assertCollection: (ps privVariables realArrayAt: v1)
		equals: #(0 2 0 0 0 0 1 0 0) asFloatArray.
	ps nsum4: v1 to: v2.
	self
		assertCollection: (ps privVariables realArrayAt: v2)
		equals: #(3 0 2 1 2 0 0 3 1) asFloatArray
]

{ #category : #'tests-command' }
SPatchesTest >> testNsum8To [
	| ps v1 v2 |
	ps := SPatches new.
	ps create: 3.
	v1 := ps addVariable: 'a'.
	v2 := ps addVariable: 'b'.
	"
0 2 0    3 1 3
0 0 0 -> 3 3 3
1 0 0    2 3 3
"
	ps var: v1 at: 2 put: 2.
	ps var: v1 at: 7 put: 1.
	self
		assertCollection: (ps privVariables realArrayAt: v1)
		equals: #(0 2 0 0 0 0 1 0 0) asFloatArray.
	ps nsum8: v1 to: v2.
	self
		assertCollection: (ps privVariables realArrayAt: v2)
		equals: #(3 1 3 3 3 3 2 3 3) asFloatArray
]

{ #category : #'tests-accessing' }
SPatchesTest >> testOrder [
	| ps |
	ps := SPatches new.
	self assert: ps order equals: ps defaultOrder.
	ps create: 120.
	self assert: ps order equals: 120.
]

{ #category : #'tests-printing' }
SPatchesTest >> testPrintOn [
	| ps |
	ps := SPatches new.
	self assert: ps asString equals: 'Patches(100x100)'.
	ps create: 10.
	self assert: ps asString equals: 'Patches(10x10)'.
]

{ #category : #'tests-private' }
SPatchesTest >> testPrivVariables [
	| ps |
	ps := SPatches new.
	self assert: ps privVariables class equals: Variables
]

{ #category : #'tests-accessing' }
SPatchesTest >> testRows [
	| ps |
	ps := SPatches new.
	self assert: ps rows equals: ps defaultOrder.
	ps create: 120.
	self assert: ps rows equals: 120.
]

{ #category : #test }
SPatchesTest >> testUseNativeDiffuser [
	| p |
	p := self newBreed.
	self deny: p isPluginDiffuser.
	p useNativeDiffuser.
	self deny: p isPluginDiffuser
]

{ #category : #test }
SPatchesTest >> testUsePluginDiffuser [
	| p |
	p := self newBreed.
	self deny: p isPluginDiffuser.
	p usePluginDiffuser.
	self assert: p isPluginDiffuser
]

{ #category : #'tests-accessing variable' }
SPatchesTest >> testVarAt [
	| ps |
	ps := SPatches new.
	ps clear.
	ps create: 4.
	self assert: (ps var: SPatchVarDef xVarNo at: 1) equals: -2.
	self assert: (ps var: SPatchVarDef xVarNo at: 2) equals: -1.
	self assert: (ps var: SPatchVarDef xVarNo at: 8) equals: 1.
	self assert: (ps var: SPatchVarDef xVarNo at: 9) equals: -2.
	self assert: (ps var: SPatchVarDef yVarNo at: 1) equals: -2.
	self assert: (ps var: SPatchVarDef yVarNo at: 2) equals: -2.
	self assert: (ps var: SPatchVarDef yVarNo at: 13) equals: 1.
	self assert: (ps var: SPatchVarDef yVarNo at: 14) equals: 1.
]

{ #category : #'tests-accessing variable' }
SPatchesTest >> testVarAtPut [
	| ps |
	ps := SPatches new.
	ps clear.
	ps create: 2.
	ps var: SPatchVarDef screenVarNo at: 1 put: 2.
	ps var: SPatchVarDef screenVarNo at: 2 put: 5.
	ps var: SPatchVarDef colorVarNo at: 1 put: 100.
	ps var: SPatchVarDef colorVarNo at: 2 put: 200.
	self assert: (ps var: SPatchVarDef screenVarNo at: 1) equals: 2.
	self assert: (ps var: SPatchVarDef screenVarNo at: 2) equals: 5.
	self assert: (ps colorAt: 1) equals: 100.
	self assert: (ps colorAt: 2) equals: 200.
]

{ #category : #'tests-accessing' }
SPatchesTest >> testXAt [
	| ps |
	ps := SPatches new.
"
	 1  2  3  4   -2 -1 0 1
	 5  6  7  8
	 9 10 11 12
	13 14 15 16
"
	ps create: 4.
	self assert: (ps xAt: 1) equals: -2.
	self assert: (ps xAt: 2) equals: -1.
	self assert: (ps xAt: 3) equals: 0.
	self assert: (ps xAt: 4) equals: 1.
	self assert: (ps xAt: 5) equals: -2.
	self assert: (ps xAt: 6) equals: -1.
	self assert: (ps xAt: 7) equals: 0.
	self assert: (ps xAt: 8) equals: 1.
	self assert: (ps xAt: 9) equals: -2.
	self assert: (ps xAt: 10) equals: -1.
	self assert: (ps xAt: 11) equals: 0.
	self assert: (ps xAt: 12) equals: 1.
	self assert: (ps xAt: 13) equals: -2.
	self assert: (ps xAt: 14) equals: -1.
	self assert: (ps xAt: 15) equals: 0.
	self assert: (ps xAt: 16) equals: 1.

"
   1  2  3  4  5   -2 -1 0 1 2
   6  7  8  9 10
  11 12 13 14 15
  16 17 18 19 20
  21 22 23 24 25
"
	ps create: 5.
	self assert: (ps xAt: 1) equals: -2.
	self assert: (ps xAt: 2) equals: -1.
	self assert: (ps xAt: 3) equals: 0.
	self assert: (ps xAt: 4) equals: 1.
	self assert: (ps xAt: 5) equals: 2.
	self assert: (ps xAt: 21) equals: -2.
	self assert: (ps xAt: 22) equals: -1.
	self assert: (ps xAt: 23) equals: 0.
	self assert: (ps xAt: 24) equals: 1.
	self assert: (ps xAt: 25) equals: 2.
]

{ #category : #'tests-accessing' }
SPatchesTest >> testYAt [
	| ps |
	ps := SPatches new.
"
	 1  2  3  4   -2
	 5  6  7  8   -1
	 9 10 11 12    0
	13 14 15 16    1
"
	ps create: 4.
	self assert: (ps yAt: 1) equals: -2.
	self assert: (ps yAt: 2) equals: -2.
	self assert: (ps yAt: 3) equals: -2.
	self assert: (ps yAt: 4) equals: -2.
	self assert: (ps yAt: 5) equals: -1.
	self assert: (ps yAt: 6) equals: -1.
	self assert: (ps yAt: 7) equals: -1.
	self assert: (ps yAt: 8) equals: -1.
	self assert: (ps yAt: 9) equals: 0.
	self assert: (ps yAt: 10) equals: 0.
	self assert: (ps yAt: 11) equals: 0.
	self assert: (ps yAt: 12) equals: 0.
	self assert: (ps yAt: 13) equals: 1.
	self assert: (ps yAt: 14) equals: 1.
	self assert: (ps yAt: 15) equals: 1.
	self assert: (ps yAt: 16) equals: 1.
"
   1  2  3  4  5   -2
   6  7  8  9 10   -1
  11 12 13 14 15    0
  16 17 18 19 20    1
  21 22 23 24 25    2
"
	ps create: 5.
	self assert: (ps yAt: 1) equals: -2.
	self assert: (ps yAt: 6) equals: -1.
	self assert: (ps yAt: 11) equals: 0.
	self assert: (ps yAt: 16) equals: 1.
	self assert: (ps yAt: 21) equals: 2.
	self assert: (ps yAt: 5) equals: -2.
	self assert: (ps yAt: 10) equals: -1.
	self assert: (ps yAt: 15) equals: 0.
	self assert: (ps yAt: 20) equals: 1.
	self assert: (ps yAt: 25) equals: 2.
]
