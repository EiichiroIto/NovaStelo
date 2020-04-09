private
add: aCharacter builder: aBlock
	(dict includesKey: aCharacter)
		ifTrue: [ self error: 'duplicate arg character' ].
	dict at: aCharacter put: aBlock