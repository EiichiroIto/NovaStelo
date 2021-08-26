"
A SDiffuser2Test is a test class for testing the behavior of SDiffuser2
"
Class {
	#name : #SNativeDiffuserTest,
	#superclass : #TestCase,
	#category : #'Stelo-Tests'
}

{ #category : #'tests-private' }
SNativeDiffuserTest >> testAllocateExtended [
	| d x |
	d := SNativeDiffuser new.
	self assert: d privExtended isNil.
	d allocateExtended: 25.
	self assert: (d privExtended isKindOf: FloatArray).
	self assert: d privExtended size equals: 25.
	x := d privExtended.
	d allocateExtended: 20.
	self assert: d privExtended equals: x.
	self assert: d privExtended size equals: 25.
	d allocateExtended: 30.
	self assert: d privExtended ~= x.
	self assert: d privExtended size equals: 30.
]

{ #category : #'tests-private' }
SNativeDiffuserTest >> testClearExtended [
	| d |
	d := SNativeDiffuser new.
	d allocateExtended: 10.
	self assert: (d privExtended allSatisfy: [ :each | each = 0 ]).
	d privExtended atAllPut: 1.
	self assert: (d privExtended allSatisfy: [ :each | each = 1 ]).
 	d clearExtended.
	self assert: (d privExtended allSatisfy: [ :each | each = 0 ]).
]

{ #category : #'tests-accessing' }
SNativeDiffuserTest >> testDiffuse4ColsRowsPercent [
	| d x |
	d := SNativeDiffuser new.
	x := FloatArray newFrom: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0).
	d diffuse4: x cols: 4 rows: 4 percent: 80.
	self assertCollection: x equals: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0) asFloatArray.
"0 0  0 0    0 0  2 0
 0 0 10 0 -> 0 2  2 2
 0 0  0 0    0 0  2 0
 0 0  0 0    0 0  0 0"
	x := FloatArray newFrom: #(0 0 0 0 0 0 10 0 0 0 0 0 0 0 0 0).
	d diffuse4: x cols: 4 rows: 4 percent: 80.
	self assertCollection: x equals: #(0 0 2 0 0 2 2 2 0 0 2 0 0 0 0 0) asFloatArray.
"0 0 0 0    0 0 0 0
 0 0 0 0    2 0 0 0
10 0 0 0 -> 2 2 0 2
 0 0 0 0    2 0 0 0"
	x := FloatArray newFrom: #(0 0 0 0 0 0 0 0 10 0 0 0 0 0 0 0).
	d diffuse4: x cols: 4 rows: 4 percent: 80.
	self assertCollection: x equals: #(0 0 0 0 2 0 0 0 2 2 0 2 2 0 0 0) asFloatArray.
"0 0 0 0    2 0 0 0
 0 0 0 0    0 0 0 0
 0 0 0 0 -> 2 0 0 0
10 0 0 0    2 2 0 2"
	x := FloatArray newFrom: #(0 0 0 0 0 0 0 0 0 0 0 0 10 0 0 0).
	d diffuse4: x cols: 4 rows: 4 percent: 80.
	self assertCollection: x equals: #(2 0 0 0 0 0 0 0 2 0 0 0 2 2 0 2) asFloatArray.
]

{ #category : #'tests-accessing' }
SNativeDiffuserTest >> testDiffuse8ColsRowsPercent [
	| d x |
	d := SNativeDiffuser new.
	x := FloatArray newFrom: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0).
	d diffuse8: x cols: 4 rows: 4 percent: 80.
	self assertCollection: x equals: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0) asFloatArray.
"0 0  0 0    0 1  1 1
 0 0 10 0 -> 0 1  2 1
 0 0  0 0    0 1  1 1
 0 0  0 0    0 0  0 0"
	x := FloatArray newFrom: #(0 0 0 0 0 0 10 0 0 0 0 0 0 0 0 0).
	d diffuse8: x cols: 4 rows: 4 percent: 80.
	self assertCollection: x equals: #(0 1 1 1 0 1 2 1 0 1 1 1 0 0 0 0) asFloatArray.
"0 0 0 0    0 0 0 0
 0 0 0 0    1 1 0 1
10 0 0 0 -> 2 1 0 1
 0 0 0 0    1 1 0 1"
	x := FloatArray newFrom: #(0 0 0 0 0 0 0 0 10 0 0 0 0 0 0 0).
	d diffuse8: x cols: 4 rows: 4 percent: 80.
	self assertCollection: x equals: #(0 0 0 0 1 1 0 1 2 1 0 1 1 1 0 1) asFloatArray.
"0 0 0 0    1 1 0 1
 0 0 0 0    0 0 0 0
 0 0 0 0 -> 1 1 0 1
10 0 0 0    2 1 0 1"
	x := FloatArray newFrom: #(0 0 0 0 0 0 0 0 0 0 0 0 10 0 0 0).
	d diffuse8: x cols: 4 rows: 4 percent: 80.
	self assertCollection: x equals: #(1 1 0 1 0 0 0 0 1 1 0 1 2 1 0 1) asFloatArray.

]

{ #category : #'tests-private' }
SNativeDiffuserTest >> testDiffusePercent [
	| d |
	d := SNativeDiffuser new.
	d privOrder: 4.
	d privNeighborSize: 8.
	d setupNeighbor.
"            0 0 0 0 0 0
 0 0  0 0    0 0 1 1 1 0
 0 0 10 0 -> 0 0 1 2 1 0
 0 0  0 0    0 0 1 1 1 0
 0 0  0 0    0 0 0 0 0 0
             0 0 0 0 0 0
"
	d allocateExtended: 36.
	d diffuse: #(0 0 0 0 0 0 10 0 0 0 0 0 0 0 0 0) asFloatArray percent: 80.
	self assertCollection: d privExtended equals: #(0 0 0 0 0 0 0 0 1 1 1 0 0 0 1 2 1 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0) asFloatArray.
"            0 0 0 0 0 0
 0  0 0 0    0 0 0 0 0 0
 0  0 0 0 -> 0 1 1 1 0 0
 0 10 0 0    0 1 2 1 0 0
 0  0 0 0    0 1 1 1 0 0
             0 0 0 0 0 0
"
	d clearExtended.
	d diffuse: #(0 0 0 0 0 0 0 0 0 10 0 0 0 0 0 0) asFloatArray percent: 80.
	self assertCollection: d privExtended equals: #(0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 0 0 1 2 1 0 0 0 1 1 1 0 0 0 0 0 0 0 0) asFloatArray.
"             0 0 0 0 0 0
 0  0  0 0    0 0 1 1 1 0
 0  0 10 0 -> 0 1 2 3 1 0
 0 10  0 0    0 1 3 2 1 0
 0  0  0 0    0 1 1 1 0 0
              0 0 0 0 0 0
"
	d clearExtended.
	d diffuse: #(0 0 0 0 0 0 10 0 0 10 0 0 0 0 0 0) asFloatArray percent: 80.
	self assertCollection: d privExtended equals: #(0 0 0 0 0 0 0 0 1 1 1 0 0 1 2 3 1 0 0 1 3 2 1 0 0 1 1 1 0 0 0 0 0 0 0 0) asFloatArray.
"           0 0 0 0 0 0
 0 0 0 0    0 0 0 0 0 0
 0 0 0 0    1 1 1 0 0 0
10 0 0 0 -> 1 2 1 0 0 0
 0 0 0 0    1 1 1 0 0 0
            0 0 0 0 0 0
"
	d clearExtended.
	d diffuse: #(0 0 0 0 0 0 0 0 10 0 0 0 0 0 0 0) asFloatArray percent: 80.
	self assertCollection: d privExtended equals: #(0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 0 0 1 2 1 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0) asFloatArray.
"           0 0 0 0 0 0
 0 0 0 0    0 0 0 0 0 0
 0 0 0 0    0 0 0 0 0 0
 0 0 0 0 -> 1 1 1 0 0 0
10 0 0 0    1 2 1 0 0 0
            1 1 1 0 0 0
"
	d clearExtended.
	d diffuse: #(0 0 0 0 0 0 0 0 0 0 0 0 10 0 0 0) asFloatArray percent: 80.
	self assertCollection: d privExtended equals: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 0 0 1 2 1 0 0 0 1 1 1 0 0 0) asFloatArray.

	d := SNativeDiffuser new.
	d privOrder: 4.
	d privNeighborSize: 4.
	d setupNeighbor.
"            0 0 0 0 0 0
 0 0  0 0    0 0 0 2 0 0
 0 0 10 0 -> 0 0 2 2 2 0
 0 0  0 0    0 0 0 2 0 0
 0 0  0 0    0 0 0 0 0 0
             0 0 0 0 0 0
"
	d allocateExtended: 36.
	d diffuse: #(0 0 0 0 0 0 10 0 0 0 0 0 0 0 0 0) asFloatArray percent: 80.
	self assertCollection: d privExtended equals: #(0 0 0 0 0 0 0 0 0 2 0 0 0 0 2 2 2 0 0 0 0 2 0 0 0 0 0 0 0 0 0 0 0 0 0 0) asFloatArray.
]

{ #category : #'tests-private' }
SNativeDiffuserTest >> testIndexOfExtendedXY [
	| d |
	d := SNativeDiffuser new.
	d privOrder: 4.
	self assert: (d indexOfExtendedX: -1 y: -1) equals: 1.
	self assert: (d indexOfExtendedX: 0 y: -1) equals: 2.
	self assert: (d indexOfExtendedX: 1 y: -1) equals: 3.
	self assert: (d indexOfExtendedX: 2 y: -1) equals: 4.
	self assert: (d indexOfExtendedX: 3 y: -1) equals: 5.
	self assert: (d indexOfExtendedX: 4 y: -1) equals: 6.
	self assert: (d indexOfExtendedX: -1 y: 0) equals: 7.
	self assert: (d indexOfExtendedX: 0 y: 0) equals: 8.
	self assert: (d indexOfExtendedX: 1 y: 0) equals: 9.
	self assert: (d indexOfExtendedX: 2 y: 0) equals: 10.
	self assert: (d indexOfExtendedX: 3 y: 0) equals: 11.
	self assert: (d indexOfExtendedX: 4 y: 0) equals: 12.
	self assert: (d indexOfExtendedX: 5 y: 0) equals: 13.
	self assert: (d indexOfExtendedX: 0 y: 1) equals: 14.
	self assert: (d indexOfExtendedX: -1 y: 3) equals: 25.
	self assert: (d indexOfExtendedX: 0 y: 3) equals: 26.
	self assert: (d indexOfExtendedX: 1 y: 3) equals: 27.
	self assert: (d indexOfExtendedX: 2 y: 3) equals: 28.
	self assert: (d indexOfExtendedX: 3 y: 3) equals: 29.
	self assert: (d indexOfExtendedX: 4 y: 3) equals: 30.
	self assert: (d indexOfExtendedX: -1 y: 4) equals: 31.
	self assert: (d indexOfExtendedX: 0 y: 4) equals: 32.
	self assert: (d indexOfExtendedX: 1 y: 4) equals: 33.
	self assert: (d indexOfExtendedX: 2 y: 4) equals: 34.
	self assert: (d indexOfExtendedX: 3 y: 4) equals: 35.
	self assert: (d indexOfExtendedX: 4 y: 4) equals: 36.

]

{ #category : #'tests-private' }
SNativeDiffuserTest >> testIndexOfNormalXY [
	| d |
	d := SNativeDiffuser new.
	d privOrder: 4.
	self assert: (d indexOfNormalX: 0 y: 0) equals: 1.
	self assert: (d indexOfNormalX: 1 y: 0) equals: 2.
	self assert: (d indexOfNormalX: 2 y: 0) equals: 3.
	self assert: (d indexOfNormalX: 3 y: 0) equals: 4.
	self assert: (d indexOfNormalX: 0 y: 1) equals: 5.
	self assert: (d indexOfNormalX: 1 y: 1) equals: 6.
	self assert: (d indexOfNormalX: 2 y: 1) equals: 7.
	self assert: (d indexOfNormalX: 3 y: 1) equals: 8.
	self assert: (d indexOfNormalX: 0 y: 2) equals: 9.
	self assert: (d indexOfNormalX: 1 y: 2) equals: 10.
	self assert: (d indexOfNormalX: 2 y: 2) equals: 11.
	self assert: (d indexOfNormalX: 3 y: 2) equals: 12.
	self assert: (d indexOfNormalX: 0 y: 3) equals: 13.
	self assert: (d indexOfNormalX: 1 y: 3) equals: 14.
	self assert: (d indexOfNormalX: 2 y: 3) equals: 15.
	self assert: (d indexOfNormalX: 3 y: 3) equals: 16.
]

{ #category : #'tests-initialization' }
SNativeDiffuserTest >> testInitialize [
	| d |
	d := SNativeDiffuser new.
	self assert: d privOrder equals: 0.
	self assert: d privNeighborSize equals: 0.
]

{ #category : #'tests-private' }
SNativeDiffuserTest >> testNsum [
	| d x |
	d := SNativeDiffuser new.
	d privOrder: 4.
	d setupNeighbor.
	d privNeighborSize: 8.
"
 1  2  3  0  1  2
 3  0  1  2  3  0    16 10 12 10
 3  2  1  0  3  2 -> 10  9 16 12
 1  0  1  3  2  0    14 10  9 11
 2  3  1  0  1  2     8 12 14 11
 1  0  2  3  1  0
"
	x := FloatArray new: 16.
	d privExtended: #(1 2 3 0 1 2 3 0 1 2 3 0 3 2 1 0 3 2 1 0 1 3 2 0 2 3 1 0 1 2 1 0 2 3 1 0) asFloatArray.
	d nsum: x.
	self assertCollection: x equals: #(16 10 12 10 10 9 16 12 14 10 9 11 8 12 14 11) asFloatArray.
]

{ #category : #'tests-accessing' }
SNativeDiffuserTest >> testNsum4DstColsRows [
	| d x |
	d := SNativeDiffuser new.
	"
0 0 0 0    0 5 0 0
0 5 0 0 -> 5 0 5 0
0 0 0 0    0 5 0 0
0 0 0 0    0 0 0 0
"
	x := FloatArray new: 16.
	d nsum4: #(0 0 0 0 0 5 0 0 0 0 0 0 0 0 0 0) asFloatArray dst: x cols: 4 rows: 4.
	self assertCollection: x equals: #(0 5 0 0 5 0 5 0 0 5 0 0 0 0 0 0) asFloatArray.
	"
0 1 0 0    1 0 2 3
0 0 1 0 -> 0 4 0 1
0 2 0 0    2 0 3 3
0 0 0 3    3 3 3 0
"
	x := FloatArray new: 16.
	d nsum4: #(0 1 0 0 0 0 1 0 0 2 0 0 0 0 0 3) asFloatArray dst: x cols: 4 rows: 4.
	self assertCollection: x equals: #(1 0 2 3 0 4 0 1 2 0 3 3 3 3 3 0) asFloatArray.
]

{ #category : #'tests-accessing' }
SNativeDiffuserTest >> testNsum8DstColsRows [
	| d x |
	d := SNativeDiffuser new.
	"
0 0 0 0    5 5 5 0
0 5 0 0 -> 5 0 5 0
0 0 0 0    5 5 5 0
0 0 0 0    0 0 0 0
"
	x := FloatArray new: 16.
	d nsum8: #(0 0 0 0 0 5 0 0 0 0 0 0 0 0 0 0) asFloatArray dst: x cols: 4 rows: 4.
	self assertCollection: x equals: #(5 5 5 0 5 0 5 0 5 5 5 0 0 0 0 0) asFloatArray.
	"
0 1 0 0    4 1 5 4
0 0 1 0 -> 3 4 3 1
0 2 0 0    5 1 6 4
0 0 0 3    6 3 6 0
"
	x := FloatArray new: 16.
	d nsum8: #(0 1 0 0 0 0 1 0 0 2 0 0 0 0 0 3) asFloatArray dst: x cols: 4 rows: 4.
	self assertCollection: x equals: #(4 1 5 4 3 4 3 1 5 1 6 4 6 3 6 0) asFloatArray
]

{ #category : #'tests-private' }
SNativeDiffuserTest >> testPrivExtended [
	| d |
	d := SNativeDiffuser new.
	self assert: d privExtended isNil.
	d privExtended: #(1 2 3).
	self assertCollection: d privExtended equals: #(1 2 3).
]

{ #category : #'tests-private' }
SNativeDiffuserTest >> testPrivNeighbor [
	| d |
	d := SNativeDiffuser new.
	self assert: d privNeighbor isNil.
	d privNeighbor: #(1 2 3).
	self assertCollection: d privNeighbor equals: #(1 2 3).
]

{ #category : #'tests-private' }
SNativeDiffuserTest >> testPrivNeighborSize [
	| d |
	d := SNativeDiffuser new.
	self assert: d privNeighborSize equals: 0.
	d privNeighborSize: 123.
	self assertCollection: d privNeighborSize equals: 123.
]

{ #category : #'tests-private' }
SNativeDiffuserTest >> testPrivOrder [
	| d |
	d := SNativeDiffuser new.
	self assert: d privOrder equals: 0.
	d privOrder: 123.
	self assertCollection: d privOrder equals: 123.
]

{ #category : #'tests-private' }
SNativeDiffuserTest >> testRestoreExtended [
	| d x |
	x := FloatArray new: 16.
	d := SNativeDiffuser new.
	d privOrder: 4.
	d privExtended: #(0 0 0 0 0 0 0 0 1 1 1 0 0 0 1 2 1 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0) asFloatArray.
	d restoreExtended: x.
	self assertCollection: x equals: #(0 1 1 1 0 1 2 1 0 1 1 1 0 0 0 0) asFloatArray.
"
1 0 1 2 3 0
1 2 3 0 1 2     5  6  2  3
3 0 1 2 3 0 ->  0  1  2  6
1 2 3 0 1 2     4  3  0  2
3 2 1 0 3 2     4  2  2 10
1 0 3 2 1 1
"
	d privExtended: #(1 0 1 2 3 0 1 2 3 0 1 2 3 0 1 2 3 0 1 2 3 0 1 2 3 2 1 0 3 2 1 0 3 2 1 1) asFloatArray.
	d restoreExtended: x.
	self assertCollection: x equals: #(5 6 2 4 0 1 2 6 4 3 0 2 4 2 2 10) asFloatArray.

]

{ #category : #'tests-private' }
SNativeDiffuserTest >> testSetupBorder [
	| d |
	d := SNativeDiffuser new.
	d privOrder: 4.
	d privExtended: #(
	 0  0  0  0  0  0
	 0  1  2  3  4  0
	 0  5  6  7  8  0
	 0  9 10 11 12  0
	 0 13 14 15 16  0
	 0  0  0  0  0  0) asFloatArray.
	d setupBorder.
	self
		assertCollection: d privExtended
		equals: #(
		16 13 14 15 16 13
		 4  1  2  3  4  1
		 8  5  6  7  8  5
	 	12  9 10 11 12  9
		16 13 14 15 16 13
		 4  1  2  3  4  1) asFloatArray
]

{ #category : #'tests-private' }
SNativeDiffuserTest >> testSetupDiffuseOrderNeighborSize [
	| d |
	d := SNativeDiffuser new.
	d setupDiffuseOrder: 4 neighborSize: 4.
	self assert: d privNeighborSize equals: 4.
	self assert: d privOrder equals: 4.
	self assert: (d privExtended allSatisfy: [ :each | each = 0 ]).
]

{ #category : #'tests-private' }
SNativeDiffuserTest >> testSetupExtended [
	| d |
	d := SNativeDiffuser new.
	d privOrder: 4.
	d allocateExtended: 36.
	d setupExtended: #(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16).
	self assert: (d privExtended isKindOf: FloatArray).
	self assertCollection: d privExtended size equals: 36.
	self
		assertCollection: d privExtended
		equals:
			#(0 0 0 0 0 0 0 1 2 3 4 0 0 5 6 7 8 0 0 9 10 11 12 0 0 13 14 15 16 0 0 0 0 0 0 0)
				asFloatArray
]

{ #category : #'tests-private' }
SNativeDiffuserTest >> testSetupNSumSrcOrderNeighborSize [
	| d |
	d := SNativeDiffuser new.
	d
		setupNSumSrc: #(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16) asFloatArray
		order: 4
		neighborSize: 4.
	self assert: d privNeighborSize equals: 4.
	self assert: d privOrder equals: 4.
	self
		assertCollection: d privExtended
		equals:
			#(16 13 14 15 16 13 4 1 2 3 4 1 8 5 6 7 8 5 12 9 10 11 12 9 16 13 14 15 16 13 4 1 2 3 4 1)
				asFloatArray.
]

{ #category : #'tests-private' }
SNativeDiffuserTest >> testSetupNeighbor [
	| d |
	d := SNativeDiffuser new.
	self assert: d privNeighbor isNil.
	d privOrder: 4.
	d setupNeighbor.
	self assert: d privNeighbor isArray.
	self assert: d privNeighbor size equals: 8.
	self assertCollection: d privNeighbor equals: #(1 -1 6 -6 5 7 -5 -7).
]
