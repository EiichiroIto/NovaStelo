accessing
off
	"Turn myself off."

	isOn ifFalse: [^ self].
	self changed.
	isOn := false.
	offForm ifNotNil: [self extent: offForm extent].
	self changed.
