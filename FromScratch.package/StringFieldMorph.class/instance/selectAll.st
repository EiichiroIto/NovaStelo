text editing
selectAll
	"Select my entire contents."

	self recordUndoState.
	selectionStart := 0.
	selectionEnd := stringMorph contents size.
	self changed.
