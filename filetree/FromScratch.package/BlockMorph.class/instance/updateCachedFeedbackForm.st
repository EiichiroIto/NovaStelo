drawing-optimization
updateCachedFeedbackForm
	"Create a cached feedback Form to show this stack's running (or error) status."

	| outlineColor |
	cachedForm ifNil: [^ self].
	outlineColor := (scratchProc notNil and: [scratchProc errorFlag])
		ifTrue: [Color r: 0.831 g: 0.156 b: 0.156]
		ifFalse: [Color gray: 0.953].

	cachedFeedbackForm := cachedForm
		outlineWidth: 3
		color: outlineColor
		depth: 8.
