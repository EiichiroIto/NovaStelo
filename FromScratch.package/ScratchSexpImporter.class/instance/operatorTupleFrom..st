private
operatorTupleFrom: aCollection
	| selector tuple |
	selector := ScratchBlockParser
				invOperatorAt: aCollection first asSymbol
				ifAbsent: [ self error ].
	tuple := aCollection copy.
	tuple at: 1 put: selector.
	self updateArgs: tuple.
	^ tuple