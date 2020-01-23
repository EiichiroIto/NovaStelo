private
assureExistsIndex: anInteger1 and: anInteger2
	| arr |
	anInteger1 > self size
		ifTrue: [ self assureExistsIndex: anInteger1 ].
	arr := array at: anInteger1.
	arr
		ifNil: [ arr := OrderedCollection new.
			array at: anInteger1 put: arr ].
	anInteger2 > arr size
		ifTrue: [ arr := arr forceTo: anInteger2 paddingWith: self defaultValue.
			array at: anInteger1 put: arr ].