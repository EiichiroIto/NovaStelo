test
testRead
	| ret |
	ret := SexpLexer new
		read:
			'(abc (de
f aaa) ghi))'.
	self
		assertCollection: ret asArray
		equals: #($( 'abc' $( 'de' 'f' 'aaa' $) 'ghi' $) $))