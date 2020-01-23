private
ensureSelectionStartPrecedesEnd
	"If selectionEnd is before selectionStart, swap them."

	| lastIndex tmp |
	lastIndex := self charCount + 1.
	selectionStart := selectionStart min: lastIndex max: 1.
	selectionEnd := selectionEnd min: lastIndex max: 1.
	selectionEnd < selectionStart ifTrue: [
		tmp := selectionEnd.
		selectionEnd := selectionStart.
		selectionStart := tmp].
