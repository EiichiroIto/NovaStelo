tests-private
testClearExtended
	| d |
	d := SDiffuser2 new.
	d allocateExtended: 10.
	self assert: (d privExtended allSatisfy: [ :each | each = 0 ]).
	d privExtended atAllPut: 1.
	self assert: (d privExtended allSatisfy: [ :each | each = 1 ]).
 	d clearExtended.
	self assert: (d privExtended allSatisfy: [ :each | each = 0 ]).