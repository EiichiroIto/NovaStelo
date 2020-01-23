accessing
listOf: anInteger
	| stream value |
	stream := WriteStream on: Array new.
	data
		do: [ :each | 
			(each size >= anInteger and: [ (value := each at: anInteger) notNil ])
				ifTrue: [ stream nextPut: value ] ].
	^ stream contents