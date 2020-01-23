test
testParseItemsTo
	| in list |
	in := ReadStream on: #('abc' 'def' $) 'ghi' $) 'aa' $) $)).
	list := OrderedCollection new.
	SexpParser new parseItems: in to: list.
	self assertCollection: list asArray equals: #('abc' 'def').
	self assert: in peek equals: 'ghi'.
	in := ReadStream on: #('abc' $( 'def' $) 'ghi' $) 'aa' $) $)).
	list := OrderedCollection new.
	SexpParser new parseItems: in to: list.
	self assertCollection: list asArray equals: #('abc' #('def') 'ghi').
	self assert: in peek equals: 'aa'