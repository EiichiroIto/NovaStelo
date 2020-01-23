initialization
initialize

	super initialize.
	self borderWidth: 0.
	self removeAllMorphs.

	self color: Color blue.
	hbarInset := 30.
	vbarInset := 25.
	scrollBarStartInset := 10.
	scrollBarEndInset := 14.
	contentsChanged := false.

	contents := PasteUpMorph new
		color: (Color gray: 0.9);
		borderWidth: 0;
		enableDragNDrop: true.

	hScrollbar := ScratchScrollBar newHorizontal
		target: self;
		selector: #hScrollRelative:.
	vScrollbar := ScratchScrollBar newVertical
		target: self;
		selector: #vScrollRelative:.

	contents position: self position + borderWidth.
	self addMorph: contents.
	self addMorph: hScrollbar.
	self addMorph: vScrollbar.
	self extent: 160@120.
