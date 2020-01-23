test
testParse
	| l ret |
	l := #( 'abc' ).
	ret := SexpParser new parse: l.
	self assert: ret equals: 'abc'.
	l := #( $( 'abc' 'def' $) ).
	ret := SexpParser new parse: l.
	self assertCollection: ret equals: #(abc def).
	l := #( $( 'abc' 'def' $( 'ghi' $) $) ).
	ret := SexpParser new parse: l.
	self assertCollection: ret equals: #(abc def (ghi)).
	l := #( $( 'abc' 'def' $( $( 'ghi' $) 'aa' $) $) ).
	ret := SexpParser new parse: l.
	self assertCollection: ret equals: #(abc def ((ghi) aa)).
	l := #( $( $( $( $) $) $) ).
	ret := SexpParser new parse: l.
	self assertCollection: ret equals: #((())).