geometry
fullBounds
	"Overridden to clip submorph hit detection to my bounds."

	fullBounds ifNil: [fullBounds := bounds].
	^ bounds
