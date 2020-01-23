accessing
classFor: aString
	| vno className |
	vno := self varNoFor: aString.
	className := self classNameForVarNo: vno.
	className ifNil: [ ^ nil ].
	^ LazyArray className: className