drawing
drawOn: aCanvas
	"Draw myself, clipping to my bounds."

	| clipC |
	clipC := aCanvas copyClipRect: self bounds.

	self bounds isWide
		ifTrue: [
			"draw horizontal frame"
			self drawHEdge: frameMiddleForm
				from: (self left + frameStartForm width)
				to: (self right - frameEndForm width)
				yOffset: 0
				on: clipC.
			clipC translucentImage: frameStartForm at: self topLeft.
			clipC translucentImage: frameEndForm at: ((self right + 1 - frameEndForm width) @ self top).

			self drawHSliderOn: clipC]	
		ifFalse: [
			"draw vertical frame"
			self drawVEdge: frameMiddleForm
				from: (self top + frameStartForm height)
				to: (self bottom - frameEndForm height)
				xOffset: 0
				on: clipC.
			clipC translucentImage: frameStartForm at: self topLeft.
			clipC translucentImage: frameEndForm at: (self left @ (self bottom + 1 - frameEndForm height)).

			self drawVSliderOn: clipC].

