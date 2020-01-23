drawing-optimization
changed
	"Don't flush my cachedForm when I do 'self changed'."

	owner ifNotNil: [owner invalidRect: (self fullBounds expandBy: 3)].
