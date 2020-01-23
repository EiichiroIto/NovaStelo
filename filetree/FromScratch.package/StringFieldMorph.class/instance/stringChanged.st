private
stringChanged
	"My string has changed. Resize myself if necessary and report the change."

	doResizing ifTrue: [
		stringMorph fitContents.
		self width: (stringMorph right - self left) + borderWidth + 3].
	(owner respondsTo: #fixArgLayout) ifTrue: [owner fixArgLayout].
	self changed.
