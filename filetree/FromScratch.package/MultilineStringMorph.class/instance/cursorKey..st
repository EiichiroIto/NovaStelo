event handling
cursorKey: evt
	"Handle the given cursor control key."

	| ch pair lineNum line |
	ch := evt keyValue.

	selectionStart = selectionEnd ifTrue: [startLoc := selectionStart].

	ch = 28 ifTrue: [ "left"
		evt shiftPressed
			ifTrue: [
				selectionEnd > startLoc
					ifTrue: [selectionEnd := selectionEnd - 1]
					ifFalse: [selectionStart := selectionStart - 1]]
			ifFalse: [
				selectionStart := selectionEnd := selectionStart - 1]].

	ch = 29 ifTrue: [ "right"
		evt shiftPressed
			ifTrue: [
				selectionStart < startLoc
					ifTrue: [selectionStart := selectionStart + 1]
					ifFalse: [selectionEnd := selectionEnd + 1]]
			ifFalse: [
				selectionStart := selectionEnd := selectionStart + 1]].

	ch = 30 ifTrue: [  "up"
		pair := self lineAndIndexFor: selectionStart.	
		lineNum := (pair first - 1) max: 1.
		line := lines at: lineNum.
		selectionStart := (self startOfLine: lineNum) + (pair second min: line size).
		evt shiftPressed ifFalse: [selectionEnd := selectionStart]].

	ch = 31 ifTrue: [  "down"
		pair := self lineAndIndexFor: selectionEnd.	
		lineNum := (pair first + 1) min: lines size.
		line := lines at: lineNum.
		selectionEnd := (self startOfLine: lineNum) + (pair second min: line size).
		evt shiftPressed ifFalse: [selectionStart := selectionEnd]].

	blinkState := true.
	self ensureSelectionStartPrecedesEnd.
	self changed.
