*FromScratch
fillRadialFromXColorBlock: colorBlock center: aPoint
	"Horizontal Gradient Fill. Supply relative x in [0.0 ... 1.0] to colorBlock, and paint each pixel with the color that comes back."

	| canvas m div t |
	canvas := self getCanvas.
	self fill: self boundingBox fillColor: (colorBlock value: 1).
	m := width max: height.
	m > 1
		ifFalse: [ ^ self ].
	div := (m - 1) asFloat.
	(m - 1) negated to: 0 do: [ :x | 
		t := x abs.
		canvas frameOval: (Rectangle center: aPoint extent: t @ t) color: (colorBlock value: t asFloat / div) ]