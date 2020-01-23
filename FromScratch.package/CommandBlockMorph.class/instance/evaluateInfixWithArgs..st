evaluation
evaluateInfixWithArgs: rawArgs
	"Evalue an infix operator with the given arguments list. Special case for comparison operatores when both operands are strings. Reverse order of comparison operands in RTL languages."
	"Note: The strings 'true' and 'false' in either English or the current language are equal to the boolean value that they name."

	| args result arg1 arg2 |
	args := rawArgs.

	#= = selector ifTrue: [
		"special case: check for equality between a boolean and the special strings 'true' or 'false'"
		((args first isString) and: [args second isKindOf: Boolean]) ifTrue: [
			(args first = 'true') ifTrue: [^ args second = true].
			(args first = 'false') ifTrue: [^ args second = false].
			"(args first = (ScratchTranslator translationFor: 'true')) ifTrue: [^ args second = true]."
			"(args first = (ScratchTranslator translationFor: 'false')) ifTrue: [^ args second = false]"].
		((args first isKindOf: Boolean) and: [args second isString]) ifTrue: [
			(args second = 'true') ifTrue: [^ args first = true].
			(args second = 'false') ifTrue: [^ args first = false].
			"(args second = (ScratchTranslator translationFor: 'true')) ifTrue: [^ args first = true]."
			"(args second = (ScratchTranslator translationFor: 'false')) ifTrue: [^ args first = false]"]].

	(#(< = >) includes: selector)
		ifTrue: [((args first isString) or: [args second isString]) ifTrue: [
				arg1 := receiver interpretStringAsNumberIfPossible: args first.
				arg2 := receiver interpretStringAsNumberIfPossible: args second.
				((arg1 isString) and: [arg2 isString]) ifTrue: [
					result := args first compare: args second.
					#< = selector ifTrue: [^ result = 1].
					#= = selector ifTrue: [^ result = 2].
					#> = selector ifTrue: [^ result = 3]].
				((arg1 isNumber) and: [arg2 isNumber]) ifTrue: [
					^ arg1 perform: selector with: arg2].
				^ false]]
		"ifFalse: [(ScratchTranslator isRTLMath and: [((selector = #\\) not)]) ifTrue: [args := args reversed]]". "RTLMath operators are RTL"

	(#(& |) includes: selector) ifTrue: [^ args first perform: selector with: args second].

	^ args first asNumberNoError perform: selector with: args second asNumberNoError
