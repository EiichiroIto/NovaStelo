layout
rightJustifyInset: anInteger
	"Right-justify the label with the given inset from the right edge."

	justification := #right.
	hOffset := anInteger.
	self updateLayout.
