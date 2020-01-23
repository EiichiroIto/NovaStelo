text editing
copySelection
	"Save the current selection in the clipboard."

	| s |
	s := stringMorph contents
		copyFrom: self leftSelection + 1
		to: self rightSelection.
	s isEmpty
		ifTrue: [ ^ self ].
	ScratchTranslator unicodeClipboardPut: s