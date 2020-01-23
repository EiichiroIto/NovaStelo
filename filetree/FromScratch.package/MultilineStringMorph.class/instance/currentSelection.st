editing
currentSelection
	"Answer the current selection as a string."

	| line result start end startLineNum endLineNum |
	self ensureSelectionStartPrecedesEnd.
	start := self lineAndIndexFor: selectionStart.
	end := self lineAndIndexFor: selectionEnd.
	startLineNum := start first.
	endLineNum := end first.

	startLineNum = endLineNum ifTrue: [
		line := lines at: startLineNum.
		^ line copyFrom: start second to: end second - 1].

	result := WriteStream on: (String new: 1000).

	line := lines at: startLineNum.
	result nextPutAll: (line copyFrom: start second to: line size).

	startLineNum + 1 to: endLineNum - 1 do: [:i |
		result nextPutAll: (lines at: i)].

	line := lines at: endLineNum.
	result nextPutAll: (line copyFrom: 1 to: end second - 1).

	^ result contents
