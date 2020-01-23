layout
leftJustifyInset: anInteger
	"Left-justify the label with the given inset from the left edge."

	justification := #left.
	hOffset := anInteger.
	self updateLayout.
