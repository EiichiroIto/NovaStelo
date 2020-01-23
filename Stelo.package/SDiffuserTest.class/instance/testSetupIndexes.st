tests-private
testSetupIndexes
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