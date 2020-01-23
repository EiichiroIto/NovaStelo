Class {
	#name : #SexpParser,
	#superclass : #Object,
	#instVars : [
		'out'
	],
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
	| token list |
	aStream atEnd
		ifTrue: [ ^ nil ].
	token := aStream next.
	token = $(
		ifTrue: [ list := OrderedCollection new.
			self parseItems: aStream to: list.
			^ list asArray ].
	^ token
]

{ #category : #private }
SexpParser >> parseItems: aStream to: aCollection [
	| item |
	[ item := self parseItem: aStream.
	item notNil ]
		whileTrue: [ item = $)
				ifTrue: [ ^ self ].
			aCollection add: item ].
	self error
]
