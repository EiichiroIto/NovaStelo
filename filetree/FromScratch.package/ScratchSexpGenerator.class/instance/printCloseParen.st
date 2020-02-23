private
printCloseParen
	stream nextPut: $).
	position := position + 1.
	indentLevel := indentLevel - 1