test
testParseItemsDelimiter
	| in list |
	in := ReadStream on: #('abc' 'def' $) 'ghi' $) 'aa' $) $)).
	list := self newParser parseItems: in delimiter: $).
	self assertCollection: list asArray equals: #('abc' 'def').
	self assert: in peek equals: 'ghi'.
	in := ReadStream on: #('abc' $( 'def' $) 'ghi' $) 'aa' $) $)).
	list := self newParser parseItems: in delimiter: $).
	self assertCollection: list asArray equals: #('abc' #('def') 'ghi').
	self assert: in peek equals: 'aa'