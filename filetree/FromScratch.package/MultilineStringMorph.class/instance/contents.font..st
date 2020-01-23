accessing
contents: aString font: aStrikeFont
	"Set my contents to the given String, UTF8, or Text and set my font. Remove non-printing characters, and replace tabs with sequences of spaces, and word-wrap."

	lines := Array with: (self replaceTabs: aString).
	self font: aStrikeFont.
