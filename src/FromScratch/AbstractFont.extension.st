Extension { #name : 'AbstractFont' }

{ #category : '*FromScratch' }
AbstractFont >> xRangesFor: aString [
	"Anwer an array of (leftX, rightX) pairs for the given string."
	"(StrikeFont fontName: 'New York' size: 12) xRangesFor: 'Hello'"
	"| f | f := StrikeFont fontName: 'New York' size: 12. (1 to: 5) collect: [:i | f widthOfString: ('Hello' copyFrom: 1 to: i)]"

	| result lastX w right |
	result := Array new: aString size.
	lastX := 0.
	1 to: aString size do: [:i |
		w := self widthOf: (aString at: i).
		right := lastX + w.
		result at: i put: (Array with: lastX with: right).
		lastX := right].

	^ result

]
