editing
deleteSelection
	"Delete the current selection."

	| start end startLineNum endLineNum s1 s2 mergedLine remainingLines |
	self ensureSelectionStartPrecedesEnd.
	selectionStart = selectionEnd ifTrue: [^ self].  "no selection"

	start := self lineAndIndexFor: selectionStart.
	end := self lineAndIndexFor: selectionEnd.

	startLineNum := start first.
	endLineNum := end first.

	"merge the partial lines before and after the selection"
	s1 := lines at: startLineNum.
	s2 := lines at: endLineNum.
	mergedLine := (s1 copyFrom: 1 to: start second - 1), (s2 copyFrom: end second to: s2 size).

	"combine with following line, if any"
	endLineNum < lines size ifTrue: [
		mergedLine := mergedLine, (lines at: endLineNum + 1).
		remainingLines := lines copyFrom: endLineNum + 2 to: lines size].

	"update lines"
	lines := (lines copyFrom: 1 to: startLineNum - 1) copyWith: mergedLine.
	remainingLines ifNotNil: [lines := lines, remainingLines].

	selectionEnd := selectionStart.
	self lineWrapFrom: startLineNum.
