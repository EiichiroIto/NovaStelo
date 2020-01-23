drawing
drawSelectionOn: aCanvas
	"Draw my selection onto the given canvas. The canvas has been offset to my origin."

	| start end startLine endLine startIndex endIndex |
	lines size = 0 ifTrue: [^ self].

	self ensureSelectionStartPrecedesEnd.
	start := self lineAndIndexFor: selectionStart.
	end := self lineAndIndexFor: selectionEnd.
	startLine := start first.
	endLine := end first.
	startIndex := start last.
	endIndex := end last.

	startLine = endLine ifTrue: [
		startIndex = endIndex
			ifTrue: [
				blinkState ifTrue: [
					self drawCursor: startIndex line: startLine on: aCanvas]]
			ifFalse: [
				self drawSelectionFrom: startIndex to: endIndex line: startLine on: aCanvas].
		^ self].

	self drawSelectionFrom: startIndex to: (lines at: startLine) size + 1 line: startLine on: aCanvas.
	startLine + 1 to: endLine - 1 do: [:i | self drawSelectionLine: i on: aCanvas].
	self drawSelectionFrom: 1 to: endIndex line: endLine on: aCanvas.
