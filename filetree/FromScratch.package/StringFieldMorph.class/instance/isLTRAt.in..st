private
isLTRAt: index in: xRange
	"True if the character at the given index in the given xRange is LTR."
	"Note: we decide direction based on the following character if possible."

	xRange size < 2 ifTrue: [^ true].  "can't tell direction from a single character; assume LTR"	

	index >= xRange size ifTrue: [
		^ (xRange at: xRange size - 1) first < xRange last first]. "at end; compare to previous character"

	^ (xRange at: index) first < (xRange at: index + 1) first
