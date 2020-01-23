private
fitContents
	"Set my extent to just fit around my contents."

	| w |
	w := 10.
	lines do: [:s | w := w max: (self widthWithContents: s)].
	super extent: (w@(lines size * lineHeight)) + (9@7).
