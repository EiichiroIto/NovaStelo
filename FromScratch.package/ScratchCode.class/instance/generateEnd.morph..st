code generator
generateEnd: aSymbol morph: aMorph
	| selector |
	selector := aSymbol copyWithout: $:.
	selector := (selector, 'End:') asSymbol.
	self perform: selector with: aMorph.