private
parseItem: aStream
	| token |
	aStream atEnd
		ifTrue: [ ^ nil ].
	token := aStream next.
	token = $(
		ifTrue: [ ^ self parseItems: aStream delimiter: $) ].
	^ token