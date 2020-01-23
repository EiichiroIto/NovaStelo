private
evaluateArg: anObject
	anObject isArray
		ifTrue: [ ^ self tupleFrom: anObject ]
		ifFalse: [ anObject isString
				ifTrue: [ anObject isNumberString
						ifTrue: [ ^ anObject asNumberNoError ] ] ].
	^ anObject