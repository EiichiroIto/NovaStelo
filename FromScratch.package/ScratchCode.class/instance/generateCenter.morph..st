code generator
generateCenter: aSymbol morph: aMorph
	| selector |
	selector := aSymbol copyWithout: $:.
	selector := (selector, 'Center:') asSymbol.
	self perform: selector with: aMorph.