drawing
drawOn: aCanvas
	"Draw the background then the selection."

	frame
		ifNil: [
			super drawOn: aCanvas]
		ifNotNil: [
			frame position: self topLeft; extent: self extent.
			frame drawOn: aCanvas].

	isKeyboardFocus ifTrue: [self drawSelectionOn: aCanvas].
