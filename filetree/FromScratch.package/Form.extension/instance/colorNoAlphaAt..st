*FromScratch
colorNoAlphaAt: aPoint
	"Answer the color in the pixel at the given point, ignoring alpha."

	^ Color colorFromPixelValue: (self pixelValueNoAlphaAt: aPoint) depth: depth
