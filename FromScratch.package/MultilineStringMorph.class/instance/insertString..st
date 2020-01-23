editing
insertString: aString
	"Insert the given string at selectionStart."

	| start lineNum line prefix postfix |
	selectionStart = selectionEnd ifFalse: [self cutSelection].

	start := self lineAndIndexFor: selectionStart.
	lineNum := start first.
	line := lines at: lineNum.
	prefix := line copyFrom: 1 to: start second - 1.
	postfix := line copyFrom: start second to: line size.

	lines at: lineNum put: (prefix, (self replaceTabs: aString), postfix).

	selectionEnd := selectionStart := selectionStart + aString size.
	self lineWrapFrom: lineNum.

