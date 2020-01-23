acccessing
read: aString
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