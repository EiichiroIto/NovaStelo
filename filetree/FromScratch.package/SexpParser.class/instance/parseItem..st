private
parseItem: aStream
	| token list |
	aStream atEnd
		ifTrue: [ ^ nil ].
	token := aStream next.
	token = $(
		ifTrue: [ list := OrderedCollection new.
			self parseItems: aStream to: list.
			^ list asArray ].
	^ token