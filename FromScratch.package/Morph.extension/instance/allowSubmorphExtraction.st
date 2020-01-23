*FromScratch
allowSubmorphExtraction
	"Return true if this morph allows its submorphs to be extracted just by grabbing them."

	self isPartsBin ifTrue: [^ false].
	^ self dragNDropEnabled or: [self dragEnabled]