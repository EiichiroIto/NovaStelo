other
clearMorphReference
	"Clear my morph reference."

	(morph isKindOf: Morph) ifFalse: [^ self].
	morph := nil.
	self updateLabel.
