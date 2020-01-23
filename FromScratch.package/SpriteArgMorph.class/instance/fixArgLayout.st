other
fixArgLayout
	"Set my color to my owner's color."

	self color: (owner color mixed: 0.7 with: (Color gray: 0.3)).
