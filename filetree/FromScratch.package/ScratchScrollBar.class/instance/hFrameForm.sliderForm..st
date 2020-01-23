initialization
hFrameForm: frameForm sliderForm: sliderForm
	"Initialize myself as a horizontal slider, setting my forms by cutting up the given forms."

	| midX h |
	"set my forms"
	midX := frameForm height // 2.
	h := frameForm height.
	frameStartForm := frameForm copy: (0@0 extent: midX@h).
	frameMiddleForm := frameForm copy: (midX@0 extent: 1@h).
	frameEndForm := frameForm copy: ((midX + 1)@0 corner: frameForm extent).

	h := sliderForm height.
	sliderStartForm := sliderForm copy: (0@0 extent: 7@h).
	sliderMiddleForm := sliderForm copy: (7@0 extent: 1@h).
	sliderEndForm := sliderForm copy: (8@0 corner: sliderForm extent).

	sliderInsets := 3@3 corner: 3@5.
	self extent: 200 @ frameStartForm height.
