test
testParseItem
	| in ret |
	in := ReadStream on: #('abc' 'def' $( $( 'ghi' $) 'aa' $) $)).
	ret := SexpParser new parseItem: in.
	self assert: ret equals: 'abc'.
	self assert: in peek equals: 'def'.
	in := ReadStream on: #($( 'ghi' $) 'aa' $) $)).
	ret := SexpParser new parseItem: in.
	self assertCollection: ret equals: #('ghi').
	self assert: in peek equals: 'aa'.