private
lineWrapFrom: startLine
	"Fix line wrapping starting at the given line."

	| lineIndex newH |
	lineIndex := startLine.
	[lineIndex <= lines size and: [self breakLine: lineIndex]]
		whileTrue: [lineIndex := lineIndex + 1].

	"if the last line ends with a CR, add a blank line after it"
	(lines last size > 0 and: [lines last last = Character cr])
		ifTrue: [lines := lines copyWith: self emptyLine].

	growWithText ifTrue: [
		newH := ((lines size max: 1) * lineHeight) + (2 * self insetY).
		bounds height ~= newH ifTrue: [self height: newH]].

	self changed.
