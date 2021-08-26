Class {
	#name : #SexpParser,
	#superclass : #Object,
	#category : #'FromScratch-Converter'
}

{ #category : #accessing }
SexpParser >> parse: aCollection [
	| in |
	in := ReadStream on: aCollection.
	^ self parseItem: in
]

{ #category : #private }
SexpParser >> parseItem: aStream [
	| token |
	aStream atEnd
		ifTrue: [ ^ nil ].
	token := aStream next.
	token = $(
		ifTrue: [ ^ self parseItems: aStream delimiter: $) ].
	^ token
]

{ #category : #private }
SexpParser >> parseItems: aStream delimiter: aCharacter [
	| list item |
	list := OrderedCollection new.
	[ item := self parseItem: aStream.
	item notNil ]
		whileTrue: [ item = aCharacter
				ifTrue: [ ^ list asArray ].
			list add: item ].
	self error
]
