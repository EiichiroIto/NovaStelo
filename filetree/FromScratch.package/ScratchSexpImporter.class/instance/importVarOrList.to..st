private
importVarOrList: anObject to: aScript
	anObject isString
		ifTrue: [ ^ aScript addVariable: anObject ].
	self assert: anObject isArray.
	anObject first = 'var'
		ifTrue: [ ^ aScript addVariable: anObject second ].
	anObject first = 'list'
		ifTrue: [ ^ aScript addList: anObject second ]