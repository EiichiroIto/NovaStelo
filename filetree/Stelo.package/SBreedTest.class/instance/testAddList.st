tests-variables
testAddList
	| br a b |
	br := SBreed new.
	a := br addList: 'a'.
	b := br addList: 'b'.
	self assert: a ~= b.
	self assert: (br privVariables privVarNames includes: 'a' ).
	self assert: (br privVariables privVarNames includes: 'b' ).
	self assert: (br varId listNames includes: 'a' ).
	self assert: (br varId listNames includes: 'b' ).