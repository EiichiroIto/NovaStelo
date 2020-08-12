private
add: aCharacter builder: aBlock
	(dict includesKey: aCharacter)
		ifTrue: [ self error: 'arg character duplicated!' ].
	dict at: aCharacter put: aBlock