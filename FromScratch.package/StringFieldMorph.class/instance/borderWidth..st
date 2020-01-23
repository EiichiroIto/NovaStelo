accessing
borderWidth: aNumber
	"Adjust the position of my stringMorph to the new border size."

	super borderWidth: (aNumber asInteger max: 0).
	stringMorph position: self position + borderWidth + (insetX@insetY).
