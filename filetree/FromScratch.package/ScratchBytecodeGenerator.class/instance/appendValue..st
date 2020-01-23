private
appendValue: anObject
	| v |
	v := anObject isBlock
		ifTrue: [ anObject value ]
		ifFalse: [ anObject ].
	v ifNil: [ ^ self ].
	stream nextPut: (ScratchBytecodeValue data: v).