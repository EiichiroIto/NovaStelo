blocks
variableBlockFromTuple: tuple receiver: scriptOwner
	"Answer a new block for the given variable reference tuple."

	| varName rcvr selector block arg argBlock |
	varName := tuple at: 2.
	rcvr := scriptOwner.
	(scriptOwner varNames includes: varName)
		ifFalse: [ scriptOwner addVariable: varName ].
	tuple first = #readVariable
		ifTrue: [ ^ VariableBlockMorph new
				commandSpec: varName;
				receiver: rcvr ].
	tuple first = #changeVariable
		ifTrue: [ selector := tuple at: 3.
			"update selector if necessary (backward compatibility):"
			selector = #set:to:
				ifTrue: [ selector := #setVar:to: ].
			block := SetterBlockMorph new receiver: rcvr.
			selector = #setVar:to:
				ifTrue: [ block initSetterForVar: varName ]
				ifFalse: [ block initChangerForVar: varName ].
			arg := tuple at: 4.
			arg isArray
				ifTrue: [ "argument is a block"
					(arg size = 1 and: [ arg first isArray ])
						ifTrue: [ arg := arg first ].
					argBlock := self blockFromTuple: arg receiver: scriptOwner.
					block replaceArgMorph: block expressionArg by: argBlock ]
				ifFalse: [ "argument is a value" block expressionArg defaultValue: arg ].
			^ block ].
	self error: 'unknown variable spec'