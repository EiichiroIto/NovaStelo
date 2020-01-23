private
replaceArgMorph: oldMorph by: newMorph
	"Replace oldMorph with newMorph in my argMorphs and submorphs lists. This is done when dropping a reporter block onto one of my arguments."

	argMorphs := argMorphs collect: [:m |
		m == oldMorph ifTrue: [newMorph] ifFalse: [m]].
	self replaceSubmorph: oldMorph by: newMorph.
	self layoutChanged.
