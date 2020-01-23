private
cBlockTupleFrom: anArray
	| tuple innerBlock |
	tuple := anArray copy.
	tuple at: 1 put: (tuple at: 1) asSymbol.
	2 to: tuple size - 1 do: [ :each | 
		| arg |
		arg := tuple at: each.
		arg isArray
			ifTrue: [ arg := self tupleFrom: arg.
				tuple at: each put: arg ] ].
	innerBlock := tuple at: tuple size.
	innerBlock := innerBlock isEmpty
		ifTrue: [ nil ]
		ifFalse: [ innerBlock collect: [ :each | self tupleFrom: each ] ].
	tuple at: tuple size put: innerBlock.
	^ tuple