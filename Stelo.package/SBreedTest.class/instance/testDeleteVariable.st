tests-variables
testDeleteVariable
	| br a b |
	br := SBreed new.
	a := br addVariable: 'a'.
	b := br addVariable: 'b'.
	self assert: a ~= b.
	br deleteVariable: 'b'.
	self assert: (br privVariables privVarNames includes: 'a' ).
	self deny: (br privVariables privVarNames includes: 'b' ).
	self assert: (br varId privVarNames includes: 'a' ).
	self deny: (br varId privVarNames includes: 'b' ).