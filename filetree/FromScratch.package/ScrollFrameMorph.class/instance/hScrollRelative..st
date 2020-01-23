scrolling
hScrollRelative: aFloat
	"Sent by the horizontal scrollbar. Scroll to the given relative postion between 0.0 and 1.0."

	self hScrollPixels: aFloat * self maxScroll x.
