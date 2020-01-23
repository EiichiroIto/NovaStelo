*FromScratch
leftMargin
	"Answer the left edge of this StringMorph. For a left-justified string, this the left edge of its bounding box, but for a right-justified string it may be inset."

	^ self left "+ (self justificationOffsetFor: contents)"