accessing
updateVarDef: aVarId
	| newVarNames newVars index class size |
	size := nil.
	newVarNames := aVarId varNames asArray.
	varNames = newVarNames
		ifTrue: [ ^ self ].
	newVars := newVarNames
		collect: [ :each | 
			index := varNames indexOf: each.
			index = 0
				ifTrue: [ class := aVarId classFor: each.
					(class notNil and: [ size notNil ])
						ifTrue: [ class forceSize: size ] ]
				ifFalse: [ class := vars at: index.
					(class notNil and: [ class isFixed ])
						ifTrue: [ size := class fixedSize ] ].
			class ].
	vars := newVars.
	varNames := newVarNames