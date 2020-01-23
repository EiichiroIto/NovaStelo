private
startOfLine: lineIndex
	"Answer the character index for the start of the line with the given index. If the line is out of range treat it as if it were the first or last line."

	| result |
	lineIndex < 1 ifTrue: [^ 1].

	result := 0.
	1 to: ((lineIndex - 1) min: lines size) do: [:i | result := result + (lines at: i) size].
	^ result
