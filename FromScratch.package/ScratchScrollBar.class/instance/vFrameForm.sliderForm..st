initialization
vFrameForm: frameForm sliderForm: sliderForm
	"Initialize myself as a vertical slider, setting my forms by cutting up the given forms."

	| midY w |
	"set my forms"
	midY := frameForm height // 2.
	w := frameForm width.
	frameStartForm := frameForm copy: (0@0 extent: w@midY).
	frameMiddleForm := frameForm copy: (0@midY extent: w@1).
	frameEndForm := frameForm copy: (0@(midY + 1) corner: frameForm extent).

	w := sliderForm width.
	sliderStartForm := sliderForm copy: (0@0 extent: w@7).
	sliderMiddleForm := sliderForm copy: (0@(7) extent: w@1).
	sliderEndForm := sliderForm copy: (0@(11) corner: sliderForm extent).

	sliderInsets := 3@3 corner: 0@5.
	self extent: frameStartForm width @ 200.
