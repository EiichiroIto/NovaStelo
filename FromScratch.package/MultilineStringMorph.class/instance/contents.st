accessing
contents
	"Answer my contents as a string."

	| sz result i |
	sz := 0.
	lines do: [:s | sz := sz + s size].
	result := String new: sz.
	i := 1.
	lines do: [:s |
		sz := s size.
		result replaceFrom: i to: i + sz - 1 with: s startingAt: 1.
		i := i + sz].
	^ result
