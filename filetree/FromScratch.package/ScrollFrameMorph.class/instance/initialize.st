initialization
initialize

	super initialize.
	self color: Color red.
	hbarInset := 12.
	vbarInset := 12.
	contentsChanged := false.
	growthFraction := 0.6.  "amount to grow when contents do not fit as a fraction of the current size"

	contents := PasteUpMorph new
		color: Color red;
		borderWidth: 0;
		enableDragNDrop: true.

	hScrollbar := ScrollBar new
		model: self;
		setValueSelector: #hScrollRelative:";
		hasMenuButton: false".
	vScrollbar := ScrollBar new
		model: self;
		setValueSelector: #vScrollRelative:";
		hasMenuButton: false".
	cornerMorph := BorderedMorph new
		borderRaised; borderWidth: 2; color: hScrollbar color.

	contents position: self position + borderWidth.
	self addMorph: contents.
	self addMorph: hScrollbar.
	self addMorph: vScrollbar.
	self addMorph: cornerMorph.
	self extent: 160@120.
