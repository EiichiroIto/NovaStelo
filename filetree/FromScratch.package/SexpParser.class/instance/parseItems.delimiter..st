private
parseItems: aStream delimiter: aCharacter
	| list item |
	list := OrderedCollection new.
	[ item := self parseItem: aStream.
	item notNil ]
		whileTrue: [ item = aCharacter
				ifTrue: [ ^ list asArray ].
			list add: item ].
	self error