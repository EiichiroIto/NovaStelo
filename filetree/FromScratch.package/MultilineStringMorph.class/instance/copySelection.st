editing
copySelection
	"Record the current selection in the clipboard."

	ScratchTranslator unicodeClipboardPut: self currentSelection.
