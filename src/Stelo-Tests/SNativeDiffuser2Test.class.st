"
A SNativeDiffuser2Test is a test class for testing the behavior of SNativeDiffuser2
"
Class {
	#name : #SNativeDiffuser2Test,
	#superclass : #TestCase,
	#category : #'Stelo-Tests'
}

{ #category : #private }
SNativeDiffuser2Test >> newDiffuser [
	^ SNativeDiffuser2 new
]

{ #category : #test }
SNativeDiffuser2Test >> testDiffuse4ColsRowsPercent [
	| d x |
	d := self newDiffuser.
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

{ #category : #test }
SNativeDiffuser2Test >> testDiffuse8ColsRowsPercent [
	| d x |
	d := self newDiffuser.
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

{ #category : #test }
SNativeDiffuser2Test >> testNsum4DstColsRows [
	| d x |
	d := self newDiffuser.
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

{ #category : #test }
SNativeDiffuser2Test >> testNsum8DstColsRows [
	| d x |
	d := self newDiffuser.
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

{ #category : #test }
SNativeDiffuser2Test >> testRolledDownToCols [
	| d r |
	d := self newDiffuser.
	r := FloatArray new: 16 withAll: 0.
	d rolledDown: (1 to: 16) asFloatArray to: r cols: 4.
	self
		assertCollection: r
		equals: #(13 14 15 16 1 2 3 4 5 6 7 8 9 10 11 12) asFloatArray.
	r := FloatArray new: 25 withAll: 0.
	d rolledDown: (1 to: 25) asFloatArray to: r cols: 5.
	self
		assertCollection: r
		equals:
			#(21 22 23 24 25 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20)
				asFloatArray
]

{ #category : #test }
SNativeDiffuser2Test >> testRolledLeftToCols [
	| d r |
	d := self newDiffuser.
	r := FloatArray new: 16 withAll: 0.
	d rolledLeft: (1 to: 16) asFloatArray to: r cols: 4.
	self
		assertCollection: r
		equals: #(2 3 4 1 6 7 8 5 10 11 12 9 14 15 16 13) asFloatArray.
	r := FloatArray new: 25 withAll: 0.
	d rolledLeft: (1 to: 25) asFloatArray to: r cols: 5.
	self
		assertCollection: r
		equals:
			#(2 3 4 5 1 7 8 9 10 6 12 13 14 15 11 17 18 19 20 16 22 23 24 25 21)
				asFloatArray
]

{ #category : #test }
SNativeDiffuser2Test >> testRolledRightToCols [
	| d r |
	d := self newDiffuser.
	r := FloatArray new: 16 withAll: 0.
	d rolledRight: (1 to: 16) asFloatArray to: r cols: 4.
	self
		assertCollection: r
		equals: #(4 1 2 3 8 5 6 7 12 9 10 11 16 13 14 15) asFloatArray.
	r := FloatArray new: 25 withAll: 0.
	d rolledRight: (1 to: 25) asFloatArray to: r cols: 5.
	self
		assertCollection: r
		equals:
			#(5 1 2 3 4 10 6 7 8 9 15 11 12 13 14 20 16 17 18 19 25 21 22 23 24)
				asFloatArray
]

{ #category : #test }
SNativeDiffuser2Test >> testRolledUpToCols [
	| d r |
	d := self newDiffuser.
	r := FloatArray new: 16 withAll: 0.
	d rolledUp: (1 to: 16) asFloatArray to: r cols: 4.
	self
		assertCollection: r
		equals: #(5 6 7 8 9 10 11 12 13 14 15 16 1 2 3 4) asFloatArray.
	r := FloatArray new: 25 withAll: 0.
	d rolledUp: (1 to: 25) asFloatArray to: r cols: 5.
	self
		assertCollection: r
		equals:
			#(6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 1 2 3 4 5)
				asFloatArray
]

{ #category : #test }
SNativeDiffuser2Test >> testScaleDstColorFromTo [

	| obj a b |
	obj := self newDiffuser.
	a := #( 10 5 1 9 ).
	b := Array new: 4.
	obj
		scale: a
		dst: b
		color: 35
		from: 1
		to: 9.
	self assertCollection: b equals: #( 9 34 30 39 )
]
