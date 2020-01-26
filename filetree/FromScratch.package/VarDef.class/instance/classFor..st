accessing
classFor: aString
	| className |
	className := self classNameFor: aString.
	className ifNil: [ ^ nil ].
	^ LazyArray className: className