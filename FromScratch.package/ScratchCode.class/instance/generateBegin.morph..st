code generator
generateBegin: aSymbol morph: aMorph
	| selector |
	selector := aSymbol copyWithout: $:.
	selector := (selector, 'Begin:') asSymbol.
	self perform: selector with: aMorph.