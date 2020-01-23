private
addLabel
	"Also add the else label"

	super addLabel.
	elseMorph := self labelMorphFor: 'else' localized.
	self addMorphBack: elseMorph.
