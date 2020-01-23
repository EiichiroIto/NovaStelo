drawing
drawNumericOn: aCanvas 

	| right topY bottomY radius xInset c |
	self computeHighlightColors.

	right := self width.
	topY := bottomY := radius := self height // 2.
	self height even ifTrue: [topY := bottomY - 1].
	[topY >= 0] whileTrue: [
		xInset := radius - (radius squared - (radius - topY - 1) squared) sqrt rounded.

		topY = 0 ifTrue: [c := highlightColor1].
		topY = 1 ifTrue: [c := highlightColor2].
		topY > 1 ifTrue: [c := color].
		self drawHLineFrom: xInset to: right - xInset y: topY color: c on: aCanvas.
		(xInset > 0) & (topY > 1) ifTrue: [
			self drawPoint: xInset@topY color: highlightColor1 on: aCanvas.
			self drawPoint: (right - xInset - 1)@topY color: highlightColor1 on: aCanvas].

		c := bottomY = (self height - 1) ifTrue: [shadowColor] ifFalse: [color].
		self drawHLineFrom: xInset to: right - xInset y: bottomY color: c on: aCanvas.
		xInset > 0 ifTrue: [
			self drawPoint: xInset@bottomY color: shadowColor on: aCanvas.
			self drawPoint: (right - xInset - 1)@bottomY color: shadowColor on: aCanvas].

		bottomY := bottomY + 1.
		topY := topY - 1].
