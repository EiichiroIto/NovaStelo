accessing
delete: aString
	| vno |
	(self includes: aString)
		ifFalse: [ self error: 'cannot delete not existing var' ].
	(self isReserved: aString)
		ifTrue: [ self error: 'cannot delete reserved var' ].
	vno := self varNoFor: aString.
	"varNames := varNames copyWithout: aString."
	varNames at: vno put: nil.
	classNames removeKey: vno