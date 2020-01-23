private
wordWrapAll
	"Redo my wordwrap."

	((lines size > 1) or: [lines first size > 0]) ifTrue: [
		self contents: self contents].
