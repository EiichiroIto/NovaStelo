initialization
initialize
	super initialize.
	isNumber := true.
	self borderWidth: 1.
	self borderInset.
	self color: ScratchTheme blockArgColor.
	self extent: 25 @ 12.

	"To allow for editing in place."
	labelMorph := StringFieldMorph new
		forExpressionArg;
		doResizing: true;
		font: (ScratchTheme argFont);
		color: Color transparent.
	self addMorph: labelMorph.
	self numExpression: '10'.