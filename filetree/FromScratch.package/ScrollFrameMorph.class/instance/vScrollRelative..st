scrolling
vScrollRelative: aFloat
	"Sent by the vertical scrollbar. Scroll to the given relative postion between 0.0 and 1.0."

	self vScrollPixels: aFloat * self maxScroll y.
