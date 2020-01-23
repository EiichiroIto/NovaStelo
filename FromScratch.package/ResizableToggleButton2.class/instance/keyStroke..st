event handling
keyStroke: evt

	| ch m |
	ch := evt unicodeChar.
	ch = 0 ifTrue: [ch := evt keyValue].

	ch = 9 ifTrue: [  "tab"
		"(m := self meOrOwnerThatIsA: DialogBoxMorph) ifNotNil: [m tabToNextField: evt]."
		^ self].

	ch = 27 ifTrue: [  "escape key"
		"(m := self meOrOwnerThatIsA: DialogBoxMorph) ifNotNil: [m escapeKeyPressed: evt]."
		^ self].

	(ch = 10) | (ch = 13) ifTrue: [  "cr, lf, or enter key"
		"(m := self meOrOwnerThatIsA: DialogBoxMorph) ifNotNil: [^ m enterKeyPressed: evt]."
		evt hand newKeyboardFocus: nil.
		^ self].

