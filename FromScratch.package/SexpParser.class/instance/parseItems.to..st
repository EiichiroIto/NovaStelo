private
parseItems: aStream to: aCollection
	| item |
	[ item := self parseItem: aStream.
	item notNil ]
		whileTrue: [ item = $)
				ifTrue: [ ^ self ].
			aCollection add: item ].
	self error