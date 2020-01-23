accessing
contents: aMorph
	"Replace my contents morph. The argument can be any morph. Typically it is a BorderedMorph or a PasteUpMorph."

	contents ifNotNil: [contents delete].
	contents := aMorph.
	contents position: self topLeft + borderWidth.
	self addMorphBack: contents.
	self extent: self extent.
