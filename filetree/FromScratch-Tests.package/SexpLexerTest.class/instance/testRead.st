test
testRead
	| ret |
	ret := SexpLexer new
		read:
			'(abc "1" (de
f aaa) ghi 5))'.
	self
		assertCollection: ret asArray
		equals: #($( 'abc' '1' $( 'de' 'f' 'aaa' $) 'ghi' 5 $) $))