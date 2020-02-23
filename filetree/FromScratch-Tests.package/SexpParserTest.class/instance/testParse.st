test
testParse
	| l ret |
	l := #( 'abc' ).
	ret := self newParser parse: l.
	self assert: ret equals: 'abc'.
	l := #( $( 'abc' 'def' $) ).
	ret := self newParser parse: l.
	self assertCollection: ret equals: #(abc def).
	l := #( $( 'abc' 'def' $( 'ghi' $) $) ).
	ret := self newParser parse: l.
	self assertCollection: ret equals: #(abc def (ghi)).
	l := #( $( 'abc' 'def' $( $( 'ghi' $) 'aa' $) $) ).
	ret := self newParser parse: l.
	self assertCollection: ret equals: #(abc def ((ghi) aa)).
	l := #( $( $( $( $) $) $) ).
	ret := self newParser parse: l.
	self assertCollection: ret equals: #((())).