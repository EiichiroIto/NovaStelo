drawing
fullDrawOn: aCanvas
	"Draw my frame in front of my submorphs."

	| clipC |
	self visible ifFalse: [^ self].
	(self hasProperty: #errorOnDraw) ifTrue:[^ self drawErrorOn: aCanvas].
	(aCanvas isVisible: self fullBounds) ifFalse: [^ self].

	"myBox has integer position and extent and has a potentially inset bottom"
	myBox := bounds truncated.
	clipC := aCanvas copyClipRect: myBox.

	frameInFront
		ifTrue: [
			self drawOn: clipC.
			self drawSubmorphsOn: clipC.
			self drawFrameOn: clipC]
		ifFalse: [
			self drawOn: clipC.
			self drawSubmorphsOn: clipC].
