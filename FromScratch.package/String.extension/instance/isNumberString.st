*FromScratch
isNumberString
	| aStream d pointNumber digitAppears |
	pointNumber := false.
	digitAppears := false.
	aStream := ReadStream on: self.
	aStream peek = $- ifTrue: [aStream next].
	[aStream atEnd]
		whileFalse: 
			[d := aStream next.
			d = $.
				ifTrue: 
					[pointNumber ifTrue: [^ false].
					pointNumber := true]
				ifFalse: [(d < $0 or: [d > $9])
						ifTrue: [^ false]
						ifFalse: [digitAppears := true]]].
	^ digitAppears