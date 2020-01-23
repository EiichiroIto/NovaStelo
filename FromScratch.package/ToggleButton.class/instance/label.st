accessing
label

	self allMorphsDo: [:m | (m isKindOf: StringMorph) ifTrue: [^ m]].
	