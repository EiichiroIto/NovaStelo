private
charCount

	| result |
	result := 0.
	lines do: [:s | result := result + s size].
	^ result
