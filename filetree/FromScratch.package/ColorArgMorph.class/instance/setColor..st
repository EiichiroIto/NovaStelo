other
setColor: aColor
	"Make sure the color is not translucent."

	self color: (aColor alpha: 1.0).
