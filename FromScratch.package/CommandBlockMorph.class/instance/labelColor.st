private
labelColor
	"Answer a label color, either black or white, that maximizes the contrast with my color."

	^ LabelColor

"old:
	^ self color luminance > 0.8
		ifTrue: [Color black]
		ifFalse: [Color white]
"
