Class {
	#name : #SexpLexer,
	#superclass : #Object,
	#category : #'FromScratch-Converter'
}

{ #category : #acccessing }
SexpLexer class >> quotedString: aString [
	^ (aString includes: Character space)
		ifTrue: [ '"' , aString , '"' ]
		ifFalse: [ aString ]
]

{ #category : #private }
SexpLexer >> delimiters [
	^ '!@#$%^&*()_+`~=[]{}\|;'',<>/?', self whiteSpaces
]

{ #category : #acccessing }
SexpLexer >> read: aString [
	| in out c token |
	in := ReadStream on: aString.
	out := WriteStream on: OrderedCollection new.
	[ in atEnd ]
		whileFalse: [ c := in peek.
			c = $"
				ifTrue: [ in next.
					token := in upTo: $".
					out nextPut: token ]
				ifFalse: [ (self delimiters includes: c)
						ifTrue: [ in next.
							(self whiteSpaces includes: c)
								ifFalse: [ out nextPut: c ] ]
						ifFalse: [ token := in upToAny: self delimiters.
							in back.
							out nextPut: token ] ] ].
	^ out contents
]

{ #category : #private }
SexpLexer >> whiteSpaces [
	^ String cr, String lf, String space, String tab
]
