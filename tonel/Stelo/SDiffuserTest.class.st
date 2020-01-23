"
A SDiffuserTest is a test class for testing the behavior of SDiffuser
"
Class {
	#name : #SDiffuserTest,
	#superclass : #TestCase,
	#category : #'Stelo-Tests'
}

{ #category : #'tests-private' }
SDiffuserTest >> testBorders [
	| d |
	d := SDiffuser neighbor4.
	self assertCollection: d borders equals: #(top left right bottom).
]

{ #category : #'tests-private' }
SDiffuserTest >> testCorners [
	| d |
	d := SDiffuser neighbor4.
	self assertCollection: d corners equals: #(topLeft topRight bottomLeft bottomRight).
]

{ #category : #'tests-accessing' }
SDiffuserTest >> testDiffuseArray [
	| d ret |
	d := SDiffuser neighbor8.
	d rows: 4 cols: 4.

	ret := d diffuse: 80 array: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0) asFloatArray.
	self assertCollection: ret equals: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0) asFloatArray.
"0 0  0 0    0 1  1 1
 0 0 10 0 -> 0 1  2 1
 0 0  0 0    0 1  1 1
 0 0  0 0    0 0  0 0"
	ret := d diffuse: 80 array: #(0 0 0 0 0 0 10 0 0 0 0 0 0 0 0 0) asFloatArray.
	self assertCollection: ret equals: #(0 1 1 1 0 1 2 1 0 1 1 1 0 0 0 0) asFloatArray.
"0 0 0 0    0 0 0 0
 0 0 0 0    1 1 0 1
10 0 0 0 -> 2 1 0 1
 0 0 0 0    1 1 0 1"
	ret := d diffuse: 80 array: #(0 0 0 0 0 0 0 0 10 0 0 0 0 0 0 0) asFloatArray.
	self assertCollection: ret equals: #(0 0 0 0 1 1 0 1 2 1 0 1 1 1 0 1) asFloatArray.
"0 0 0 0    1 1 0 1
 0 0 0 0    0 0 0 0
 0 0 0 0 -> 1 1 0 1
10 0 0 0    2 1 0 1"
	ret := d diffuse: 80 array: #(0 0 0 0 0 0 0 0 0 0 0 0 10 0 0 0) asFloatArray.
	self assertCollection: ret equals: #(1 1 0 1 0 0 0 0 1 1 0 1 2 1 0 1) asFloatArray.
]

{ #category : #'tests-private' }
SDiffuserTest >> testDiffuseBorderAt [
	| d |
	d := SDiffuser neighbor8.
	d rows: 4 cols: 4.
"
 0  0  0  0    1  0  1  1
 0  0  0 10    1  0  1  2
 0  0  0  0 -> 1  0  1  1
 0  0  0  0    0  0  0  0
"
	d privSrc: #(0 0 0 0 0 0 0 10 0 0 0 0 0 0 0 0) asFloatArray.
	d diffuseBorder: 80 at: #right.
	self assertCollection: d result equals: #(1 0 1 1 1 0 1 2 1 0 1 1 0 0 0 0) asFloatArray.
"
 0  0 10  0    0  1  2  1
 0  0  0  0    0  1  1  1
 0  0  0  0 -> 0  0  0  0
 0  0  0  0    0  1  1  1
"
	d privSrc: #(0 0 10 0 0 0 0 0 0 0 0 0 0 0 0 0) asFloatArray.
	d diffuseBorder: 80 at: #top.
	self assertCollection: d result equals: #(0 1 2 1 0 1 1 1 0 0 0 0 0 1 1 1) asFloatArray.
"0 0 0 0    0 0 0 0
 0 0 0 0    1 1 0 1
10 0 0 0 -> 2 1 0 1
 0 0 0 0    1 1 0 1"
	d privSrc: #(0 0 0 0 0 0 0 0 10 0 0 0 0 0 0 0) asFloatArray.
	d diffuseBorder: 80 at: #left.
	self assertCollection: d result equals: #(0 0 0 0 1 1 0 1 2 1 0 1 1 1 0 1) asFloatArray.
"
 0  0  0  0     1  1  1  0
 0  0  0  0 ->  0  0  0  0
 0  0  0  0     1  1  1  0
 0 10  0  0     1  2  1  0
"
	d privSrc: #(0 0 0 0 0 0 0 0 0 0 0 0 0 10 0 0) asFloatArray.
	d diffuseBorder: 80 at: #bottom.
	self assertCollection: d result equals: #(1 1 1 0 0 0 0 0 1 1 1 0 1 2 1 0) asFloatArray.
]

{ #category : #'tests-private' }
SDiffuserTest >> testDiffuseCornerAt [
	| d |
	d := SDiffuser neighbor4.
	d rows: 4 cols: 4.
"
10  0  0  0    2  2  0  2
 0  0  0  0    2  0  0  0
 0  0  0  0 -> 0  0  0  0
 0  0  0  0    2  0  0  0
"
	d privSrc: #(10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0) asFloatArray.
	d diffuseCorner: 80 at: #topLeft.
	self assertCollection: d result equals: #(2 2 0 2 2 0 0 0 0 0 0 0 2 0 0 0) asFloatArray.
"
 0  0  0 10    2  0  2  2
 0  0  0  0    0  0  0  2
 0  0  0  0 -> 0  0  0  0
 0  0  0  0    0  0  0  2
"
	d privSrc: #(0 0 0 10 0 0 0 0 0 0 0 0 0 0 0 0) asFloatArray.
	d diffuseCorner: 80 at: #topRight.
	self assertCollection: d result equals: #(2 0 2 2 0 0 0 2 0 0 0 0 0 0 0 2) asFloatArray.
"
 0  0  0  0    2  0  0  0
 0  0  0  0    0  0  0  0
 0  0  0  0 -> 2  0  0  0
10  0  0  0    2  2  0  2
"
	d privSrc: #(0 0 0 0 0 0 0 0 0 0 0 0 10 0 0 0) asFloatArray.
	d diffuseCorner: 80 at: #bottomLeft.
	self assertCollection: d result equals: #(2 0 0 0 0 0 0 0 2 0 0 0 2 2 0 2) asFloatArray.
"
 0  0  0  0    0  0  0  2
 0  0  0  0    0  0  0  0
 0  0  0  0 -> 0  0  0  2
 0  0  0 10    2  0  2  2
"
	d privSrc: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10) asFloatArray.
	d diffuseCorner: 80 at: #bottomRight.
	self assertCollection: d result equals: #(0 0 0 2 0 0 0 0 0 0 0 2 2 0 2 2) asFloatArray.

	d := SDiffuser neighbor8.
	d rows: 4 cols: 4.
"
10  0  0  0    2  1  0  1
 0  0  0  0    1  1  0  1
 0  0  0  0 -> 0  0  0  0
 0  0  0  0    1  1  0  1
"
	d privSrc: #(10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0) asFloatArray.
	d diffuseCorner: 80 at: #topLeft.
	self assertCollection: d result equals: #(2 1 0 1 1 1 0 1 0 0 0 0 1 1 0 1) asFloatArray.
"
 0  0  0 10    1  0  1  2
 0  0  0  0    1  0  1  1
 0  0  0  0 -> 0  0  0  0
 0  0  0  0    1  0  1  1
"
	d privSrc: #(0 0 0 10 0 0 0 0 0 0 0 0 0 0 0 0) asFloatArray.
	d diffuseCorner: 80 at: #topRight.
	self assertCollection: d result equals: #(1 0 1 2 1 0 1 1 0 0 0 0 1 0 1 1) asFloatArray.
"
 0  0  0  0    1  1  0  1
 0  0  0  0    0  0  0  0
 0  0  0  0 -> 1  1  0  1
10  0  0  0    2  1  0  1
"
	d privSrc: #(0 0 0 0 0 0 0 0 0 0 0 0 10 0 0 0) asFloatArray.
	d diffuseCorner: 80 at: #bottomLeft.
	self assertCollection: d result equals: #(1 1 0 1 0 0 0 0 1 1 0 1 2 1 0 1) asFloatArray.
"
 0  0  0  0    1  0  1  1
 0  0  0  0    0  0  0  0
 0  0  0  0 -> 1  0  1  1
 0  0  0 10    1  0  1  2
"
	d privSrc: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10) asFloatArray.
	d diffuseCorner: 80 at: #bottomRight.
	self assertCollection: d result equals: #(1 0 1 1 0 0 0 0 1 0 1 1 1 0 1 2) asFloatArray.
]

{ #category : #'tests-private' }
SDiffuserTest >> testDiffuseInner [
	| d |
	d := SDiffuser neighbor8.
	d rows: 4 cols: 4.

	d privSrc: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0).
	d diffuseInner: 80.
	self assertCollection: d result equals: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0) asFloatArray.
"0 0  0 0    0 1  1 1
 0 0 10 0 -> 0 1  2 1
 0 0  0 0    0 1  1 1
 0 0  0 0    0 0  0 0"
	d privSrc: #(0 0 0 0 0 0 10 0 0 0 0 0 0 0 0 0).
	d diffuseInner: 80.
	self assertCollection: d result equals: #(0 1 1 1 0 1 2 1 0 1 1 1 0 0 0 0) asFloatArray.
]

{ #category : #'tests-accessing' }
SDiffuserTest >> testNsum [
	| d ret |
	d := SDiffuser neighbor8.
	d rows: 4 cols: 4.
"
0 0 0 0    5 5 5 0
0 5 0 0 -> 5 0 5 0
0 0 0 0    5 5 5 0
0 0 0 0    0 0 0 0
"
	ret := d nsum: #(0 1 0 0 0 0 1 0 0 2 0 0 0 0 0 3) asFloatArray.
	self assertCollection: ret equals: #(4 1 5 4 3 4 3 1 5 1 6 4 6 3 6 0) asFloatArray.
"
0 1 0 0    4 1 5 4
0 0 1 0 -> 3 4 3 1
0 2 0 0    5 1 6 4
0 0 0 3    6 3 6 0
"
	ret := d nsum: #(0 1 0 0 0 0 1 0 0 2 0 0 0 0 0 3) asFloatArray.
	self assertCollection: ret equals: #(4 1 5 4 3 4 3 1 5 1 6 4 6 3 6 0) asFloatArray.
]

{ #category : #'tests-private' }
SDiffuserTest >> testNsumBorderAt [
	| d  |
	d := SDiffuser neighbor8.
	d rows: 4 cols: 4.
"
0 1 0 0    0 1 5 0
0 0 1 0 -> 0 0 0 0
0 2 0 0    0 0 0 0
0 0 0 3    0 0 0 0
"
	d privSrc: #(0 1 0 0 0 0 1 0 0 2 0 0 0 0 0 3) asFloatArray.
	d nsumBorderAt: #top.
	self assertCollection: d result equals: #(0 1 5 0 0 0 0 0 0 0 0 0 0 0 0 0) asFloatArray.
"
0 1 0 0    0 0 0 0
0 0 1 0 -> 3 0 0 0
0 2 0 0    5 0 0 0
0 0 0 3    0 0 0 0
"
	d privSrc:  #(0 1 0 0 0 0 1 0 0 2 0 0 0 0 0 3) asFloatArray.
	d nsumBorderAt: #left.
	self assertCollection: d result equals: #(0 0 0 0 3 0 0 0 5 0 0 0 0 0 0 0) asFloatArray.
"
0 1 0 0    0 0 0 0
0 0 1 0 -> 0 0 0 2
1 2 0 0    0 0 0 5
0 0 0 3    0 0 0 0
"
	d privSrc:  #(0 1 0 0 0 0 1 0 1 2 0 0 0 0 0 3) asFloatArray.
	d nsumBorderAt: #right.
	self assertCollection: d result equals: #(0 0 0 0 0 0 0 2 0 0 0 5 0 0 0 0) asFloatArray.
"
0 1 0 0    0 0 0 0
0 0 1 0 -> 0 0 0 0
0 2 0 0    0 0 0 0
0 0 0 3    0 3 6 0
"
	d privSrc: #(0 1 0 0 0 0 1 0 0 2 0 0 0 0 0 3) asFloatArray.
	d nsumBorderAt: #bottom.
	self assertCollection: d result equals: #(0 0 0 0 0 0 0 0 0 0 0 0 0 3 6 0) asFloatArray.
]

{ #category : #'tests-private' }
SDiffuserTest >> testNsumCornerAt [
	| d |
	d := SDiffuser neighbor4.
	d rows: 4 cols: 4.
"
0 1 0 0    1 0 0 0
0 0 1 0 -> 0 0 0 0
0 2 0 0    0 0 0 0
0 0 0 3    0 0 0 0
"
	d privSrc: #(0 1 0 0 0 0 1 0 0 2 0 0 0 0 0 3) asFloatArray.
	d nsumCornerAt: #topLeft.
	self assertCollection: d result equals: #(1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0) asFloatArray.
"
0 1 0 0    0 0 0 3
0 0 1 0 -> 0 0 0 0
0 2 0 0    0 0 0 0
0 0 0 3    0 0 0 0
"
	d privSrc: #(0 1 0 0 0 0 1 0 0 2 0 0 0 0 0 3) asFloatArray.
	d nsumCornerAt: #topRight.
	self assertCollection: d result equals: #(0 0 0 3 0 0 0 0 0 0 0 0 0 0 0 0) asFloatArray.
"
0 1 0 0    0 0 0 0
0 0 1 0 -> 0 0 0 0
1 2 0 0    0 0 0 0
0 0 0 3    4 0 0 0
"
	d privSrc: #(0 1 0 0 0 0 1 0 1 2 0 0 0 0 0 3) asFloatArray.
	d nsumCornerAt: #bottomLeft.
	self assertCollection: d result equals: #(0 0 0 0 0 0 0 0 0 0 0 0 4 0 0 0) asFloatArray.
"
0 1 1 0    0 0 0 0
0 0 1 0 -> 0 0 0 0
0 2 0 2    0 0 0 0
1 0 0 3    0 0 0 3
"
	d privSrc: #(0 1 1 0 0 0 1 0 0 2 0 2 1 0 0 3) asFloatArray.
	d nsumCornerAt: #bottomRight.
	self assertCollection: d result equals: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 3) asFloatArray.

	d := SDiffuser neighbor8.
	d rows: 4 cols: 4.
"
0 1 0 0    4 0 0 0
0 0 1 0 -> 0 0 0 0
0 2 0 0    0 0 0 0
0 0 0 3    0 0 0 0
"
	d privSrc: #(0 1 0 0 0 0 1 0 0 2 0 0 0 0 0 3) asFloatArray.
	d nsumCornerAt: #topLeft.
	self assertCollection: d result equals: #(4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0) asFloatArray.
"
0 1 0 0    0 0 0 4
0 0 1 0 -> 0 0 0 0
0 2 0 0    0 0 0 0
0 0 0 3    0 0 0 0
"
	d privSrc: #(0 1 0 0 0 0 1 0 0 2 0 0 0 0 0 3) asFloatArray.
	d nsumCornerAt: #topRight.
	self assertCollection: d result equals: #(0 0 0 4 0 0 0 0 0 0 0 0 0 0 0 0) asFloatArray.
"
0 1 0 0    0 0 0 0
0 0 1 0 -> 0 0 0 0
1 2 0 0    0 0 0 0
0 0 0 3    7 0 0 0
"
	d privSrc: #(0 1 0 0 0 0 1 0 1 2 0 0 0 0 0 3) asFloatArray.
	d nsumCornerAt: #bottomLeft.
	self assertCollection: d result equals: #(0 0 0 0 0 0 0 0 0 0 0 0 7 0 0 0) asFloatArray.
"
0 1 1 0    0 0 0 0
0 0 1 0 -> 0 0 0 0
0 2 0 2    0 0 0 0
1 0 0 3    0 0 0 1
"
	d privSrc: #(0 1 1 0 0 0 1 0 0 2 0 2 1 0 0 3) asFloatArray.
	d nsumCornerAt: #bottomRight.
	self assertCollection: d result equals: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4) asFloatArray.
]

{ #category : #'tests-private' }
SDiffuserTest >> testNsumInner [
	| d |
	d := SDiffuser neighbor8.
	d rows: 4 cols: 4.
"
0 0 0 0    0 0 0 0
0 0 1 0 -> 0 3 2 0
0 2 0 0    0 1 3 0
0 0 0 0    0 0 0 0
"
	d privSrc: #(0 0 0 0 0 0 1 0 0 2 0 0 0 0 0 0) asFloatArray.
	d nsumInner.
	self assertCollection: d result equals: #(0 0 0 0 0 3 2 0 0 1 3 0 0 0 0 0) asFloatArray.
]

{ #category : #'tests-private' }
SDiffuserTest >> testPrivCols [
	self testRowsCols.
]

{ #category : #'tests-private' }
SDiffuserTest >> testPrivCornerIndexes [
	self testSetupNeighbor4.
]

{ #category : #'tests-private' }
SDiffuserTest >> testPrivDst [
	self testResult.
]

{ #category : #'tests-private' }
SDiffuserTest >> testPrivIndexesDict [
	self testSetupIndexes.
]

{ #category : #'tests-private' }
SDiffuserTest >> testPrivNeighbor [
	self testSetupNeighbor4.
]

{ #category : #'tests-private' }
SDiffuserTest >> testPrivRows [
	self testRowsCols.
]

{ #category : #'tests-private' }
SDiffuserTest >> testPrivSrc [
	| d |
	d := SDiffuser neighbor4.
	self assert: d result isNil.
	d privSrc: #(1 2 3).
	self assertCollection: d privSrc equals: #(1 2 3).
	self assertCollection: d result equals: #(0 0 0) asFloatArray.
]

{ #category : #'tests-accessing' }
SDiffuserTest >> testResult [
	| d |
	d := SDiffuser neighbor4.
	self assert: d result isNil.
	d privDst: 123.
	self assert: d result equals: 123.
	d privDst: 456.
	self assert: d result equals: 456.
]

{ #category : #'tests-accessing' }
SDiffuserTest >> testRowsCols [
	| d |
	d := SDiffuser neighbor4.
	self assert: d privRows isNil.
	self assert: d privCols isNil.
	d rows: 3 cols: 4.
	self assert: d privRows equals: 3.
	self assert: d privCols equals: 4.
]

{ #category : #'tests-private' }
SDiffuserTest >> testSetupIndexes [
	| d dict bag |
	d := SDiffuser neighbor8.
	d rows: 5 cols: 5.
	d setupIndexes.

	d privSrc: #(1 2 3).
	dict := d privIndexesDict.
	"
5 6 0 0 4 - 6 0 0 4 5 - 8 9 0 0 7 - 9 0 0 7 8
8 9 0 0 7 - 9 0 0 7 8 - 0 0 0 0 0 - 0 0 0 0 0
0 0 0 0 0 - 0 0 0 0 0 - 0 0 0 0 0 - 0 0 0 0 0
0 0 0 0 0 - 0 0 0 0 0 - 2 3 0 0 1 - 3 0 0 1 2
2 3 0 0 1 - 3 0 0 1 2 - 5 6 0 0 4 - 6 0 0 4 5
"
	self assertCollection: (dict at: #topLeft) equals: #(25 21 22 5 1 2 10 6 7).
	self assertCollection: (dict at: #topRight) equals: #(24 25 21 4 5 1 9 10 6).
	self assertCollection: (dict at: #bottomLeft) equals: #(20 16 17 25 21 22 5 1 2).
	self assertCollection: (dict at: #bottomRight) equals: #(19 20 16 24 25 21 4 5 1).
	"
 6  7  8  9 10 - 11 12 13 14 15
11 12 13 14 15 -  0  0  0  0  0
 0  0  0  0  0 -  0  0  0  0  0
 0  0  0  0  0 -  1  2  3  4  5
 1  2  3  4  5 -  6  7  8  9 10
"
	self assertCollection: (dict at: #top) equals: #(21 22 23 24 25 1 2 3 4 5 6 7 8 9 10).
	self
		assertCollection: (dict at: #bottom)
		equals: #(16 17 18 19 20 21 22 23 24 25 1 2 3 4 5).
	"
 6 11  0  0  1 - 11  0  0  1  6
 7 12  0  0  2 - 12  0  0  2  7
 8 13  0  0  3 - 13  0  0  3  8
 9 14  0  0  4 - 14  0  0  4  9
10 15  0  0  5 - 15  0  0  5 10
"
	self
		assertCollection: (dict at: #left)
		equals: #(5 10 15 20 25 1 6 11 16 21 2 7 12 17 22).
	self
		assertCollection: (dict at: #right)
		equals: #(4 9 14 19 24 5 10 15 20 25 1 6 11 16 21).
	self assertCollection: (dict at: #inner) equals: #(7 8 9 12 13 14 17 18 19).
	bag := Bag new.
	bag add: ((dict at: #topLeft) at: 5).
	bag add: ((dict at: #topRight) at: 5).
	bag add: ((dict at: #bottomLeft) at: 5).
	bag add: ((dict at: #bottomRight) at: 5).
	bag addAll: ((dict at: #top) copyFrom: 7 to: 9).
	bag addAll: ((dict at: #left) copyFrom: 7 to: 9).
	bag addAll: ((dict at: #right) copyFrom: 7 to: 9).
	bag addAll: ((dict at: #bottom) copyFrom: 7 to: 9).
	bag addAll: (dict at: #inner).
	self assert: bag size equals: 25.
	1 to: 25 do: [ :each | 
		self assert: (bag includes: each).
		self assert: (bag occurrencesOf: each) equals: 1 ].
]

{ #category : #'tests-private' }
SDiffuserTest >> testSetupNeighbor4 [
	| d |
	d := SDiffuser neighbor4.
	d rows: 5 cols: 6.
	d setupNeighbor4.
	self assertCollection: d privNeighbor equals: #(1 -1 -5 5).
	self assertCollection: d privCornerIndexes equals: #(2 4 6 8).
]

{ #category : #'tests-private' }
SDiffuserTest >> testSetupNeighbor8 [
	| d |
	d := SDiffuser neighbor8.
	d rows: 5 cols: 6.
	d setupNeighbor8.
	self assertCollection: d privNeighbor equals: #(1 -1 -6 -5 -4 4 5 6).
	self assertCollection: d privCornerIndexes equals: #(1 2 3 4 6 7 8 9).
]

{ #category : #'tests-private' }
SDiffuserTest >> testSetupSelector [
	| d |
	d := SDiffuser neighbor4.
	self assert: d setupSelector equals: #setupNeighbor4.
	d setupSelector: #abc.
	self assert: d setupSelector equals: #abc.
	d := SDiffuser neighbor8.
	self assert: d setupSelector equals: #setupNeighbor8.
]
