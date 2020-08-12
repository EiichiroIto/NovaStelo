private
newLabelMorph
	^ StringFieldMorph new
		forExpressionArg;
		doResizing: true;
		font: ScratchTranslator argFont;
		color: Color transparent;
		isNumeric: false;
		contents: ''