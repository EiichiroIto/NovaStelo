private
printString: aString
	aString asString
		do: [ :c | 
			c = $(
				ifTrue: [ self printOpenParen ]
				ifFalse: [ c = $)
						ifTrue: [ self printCloseParen ]
						ifFalse: [ self printChar: c ] ] ]