event handling
keyStroke: evt

	| ch m |
	ch := evt keyCharacter charCode.
	ch = 0 ifTrue: [ch := evt keyValue].

	evt commandKeyPressed ifTrue: [ch := ch \\ 32].	"map cmd/alt keys to control keys"
	(ch = 3) & (evt buttons = 0) ifTrue: [ch := 13].	"map enter key to cr"

	ch = 9 ifTrue: [  "tab"
		"(m := self meOrOwnerThatIsA: DialogBoxMorph) ifNotNil: [m tabToNextField: evt]."
		^ self].

	ch = 27 ifTrue: [  "escape key"
		"(m := self meOrOwnerThatIsA: DialogBoxMorph) ifNotNil: [m escapeKeyPressed: evt]."
		^ self].

	evt controlKeyPressed | evt commandKeyPressed ifTrue: [	"ctrl (or alt) is pressed"
		ch = 1 ifTrue: [^ self selectAll].			"ctrl-a"
		ch = 3 ifTrue: [^ self copySelection].		"ctrl-c"
		ch = 22 ifTrue: [^ self paste].			"ctrl-v"
		ch = 24 ifTrue: [^ self cutSelection]].		"ctrl-x"

	evt shiftPressed ifTrue: [ "shift is pressed"
		ch = 1 ifTrue: [^ self moveCursorHomeAndSelect: true].		"home"
		ch = 4 ifTrue: [^ self moveCursorEndAndSelect: true].			"end"
		ch = 11 ifTrue: [^ self moveCursorPageUpAndSelect: true].		"page up"
		ch = 12 ifTrue: [^ self moveCursorPageDownAndSelect: true]].	"page down"

	evt buttons = 0 ifTrue: [ "no modifier keys"
		ch = 8 ifTrue: [^ self backspaceChar].						"backspace"
		ch = 127 ifTrue: [^ self deleteNextChar].						"delete"
		ch = 1 ifTrue: [^ self moveCursorHomeAndSelect: false].		"home"
		ch = 4 ifTrue: [^ self moveCursorEndAndSelect: false].		"end"
		ch = 11 ifTrue: [^ self moveCursorPageUpAndSelect: false].	"page up"
		ch = 12 ifTrue: [^ self moveCursorPageDownAndSelect: false]]."page down"

	(ch between: 28 and: 31) ifTrue: [^ self cursorKey: evt].  "arrow keys"

	"not a special character--just insert it"
	self insertString: evt keyCharacter asString