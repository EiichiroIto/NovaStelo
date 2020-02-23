private
printOpenParen
	wantsLinefeed
		ifTrue: [ wantsLinefeed := false.
			self printLinefeed.
			indentLevel > 0
				ifTrue: [ self printSpaces: (indents at: indentLevel) ] ].
	stream nextPut: $(.
	position := position + 1.
	indentLevel := indentLevel + 1.
	indents size < indentLevel
		ifTrue: [ indents := indents grownBy: indentLevel - indents size ].
	indents at: indentLevel put: position