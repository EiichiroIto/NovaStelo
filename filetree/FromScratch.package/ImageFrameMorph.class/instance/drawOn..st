drawing
drawOn: aCanvas
	"Draw my background."

	"myBox has integer position and extent and has a potentially inset bottom"
	myBox := bounds origin truncated corner: (bounds right@self insetBottom) truncated.

	self drawBackgroundOn: aCanvas.

	frameInFront ifFalse: [self drawFrameOn: aCanvas].
