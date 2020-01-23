text editing
recordUndoState
	"Remember the current contents and selection to allow undo."

	undoState := Array
		with: stringMorph contents
		with: selectionStart
		with: selectionEnd.
