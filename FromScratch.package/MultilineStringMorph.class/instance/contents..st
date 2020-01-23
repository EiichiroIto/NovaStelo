accessing
contents: aStringOrText
	"Set my contents to the given String or Text. Break into lines, emove non-printing characters, and replace tabs with sequences of spaces."

	lines := Array with: (self replaceTabs: aStringOrText).
	self lineWrapFrom: 1.
