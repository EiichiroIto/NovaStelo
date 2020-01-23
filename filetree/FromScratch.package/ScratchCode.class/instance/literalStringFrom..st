private
literalStringFrom: anObject
	anObject isString
		ifTrue: [ ^ anObject asNumberNoError ].
	anObject isNumber
		ifTrue: [ ^ anObject ].
	^ 0