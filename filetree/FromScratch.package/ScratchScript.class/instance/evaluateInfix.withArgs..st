evaluation
evaluateInfix: aSymbol withArgs: rawArgs
	"Evalue an infix operator with the given arguments list. Special case for comparison operatores when both operands are strings. Reverse order of comparison operands in RTL languages."

	"Note: The strings 'true' and 'false' in either English or the current language are equal to the boolean value that they name."

	| arg1 arg2 |
	arg1 := rawArgs first.
	arg2 := rawArgs second.
	#= = aSymbol
		ifTrue: [ (arg1 isString and: [ arg2 isKindOf: Boolean ])
				ifTrue: [ arg1 = 'true'
						ifTrue: [ ^ arg2 = true ].
					arg1 = 'false'
						ifTrue: [ ^ arg2 = false ] ].
			((arg1 isKindOf: Boolean) and: [ arg2 isString ])
				ifTrue: [ arg2 = 'true'
						ifTrue: [ ^ arg1 = true ].
					arg2 = 'false'
						ifTrue: [ ^ arg1 = false ] ] ].
	(#(< = >) includes: aSymbol)
		ifTrue: [ (arg1 isString and: [ arg1 isNumberString ])
				ifTrue: [ arg1 := arg1 asNumber ].
			(arg2 isString and: [ arg2 isNumberString ])
				ifTrue: [ arg2 := arg2 asNumber ].
			((arg1 isNumber and: [ arg2 isNumber ])
				or: [ arg1 isString and: [ arg2 isString ] ])
				ifTrue: [ ^ arg1 perform: aSymbol with: arg2 ].
			^ false ].
	(#(& |) includes: aSymbol)
		ifTrue: [ ^ arg1 perform: aSymbol with: arg2 ].
	^ arg1 asNumberNoError perform: aSymbol with: arg2 asNumberNoError