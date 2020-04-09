private
newLabelMorph
	^ StringFieldMorph new
		forExpressionArg;
		doResizing: true;
		font: ScratchTheme argFont;
		color: Color transparent;
		isNumeric: false;
		contents: ''