"
A SPluginDiffuserTest is a test class for testing the behavior of SPluginDiffuser
"
Class {
	#name : #SPluginDiffuserTest,
	#superclass : #TestCase,
	#category : #'Stelo-Tests'
}

{ #category : #private }
SPluginDiffuserTest >> newDiffuser [
	^ SPluginDiffuser new
]

{ #category : #test }
SPluginDiffuserTest >> testDiffuse4ColsRowsPercent [
	| d x |
	SteloPlugin2 isAvailable
		ifFalse: [ ^ self ].
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
SPluginDiffuserTest >> testDiffuse8ColsRowsPercent [
	| d x |
	SteloPlugin2 isAvailable
		ifFalse: [ ^ self ].
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
SPluginDiffuserTest >> testIsPluginDiffuser [
	| d |
	d := self newDiffuser.
	self assert: d isPluginDiffuser
]

{ #category : #test }
SPluginDiffuserTest >> testNsum4DstColsRows [
	| d x |
	SteloPlugin2 isAvailable
		ifFalse: [ ^ self ].
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
SPluginDiffuserTest >> testNsum8DstColsRows [
	| d x |
	SteloPlugin2 isAvailable
		ifFalse: [ ^ self ].
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
