menus
tabToNextField: evt
	"Move the keyboard focus to the next submorph that responds to keyboard events."

	| fields current |
	fields := argMorphs select: [:m | m isKindOf: ExpressionArgMorph].

	current := (1 to: fields size) detect: [:i | (fields at: i) labelMorph == evt hand keyboardFocus] ifNone: [fields size].
	evt hand newKeyboardFocus: (fields at: (current \\ fields size) + 1) labelMorph.
