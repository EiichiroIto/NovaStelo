private
setCurrent: aMorph
	"Make the given morph be the one currently displayed."

	aMorph ifNil: [^ self].  "should not happen"
	aMorph
		position: self position;
		extent: self extent.

	current delete.
	current := aMorph.
	self addMorphBack: current.

