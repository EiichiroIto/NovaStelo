drawing
drawSubmorphsOn: aCanvas
	"If my contents has changed, fix it's extent and update my scrollbar ranges. Clip submorph drawing to my bounds."

	contentsChanged ifTrue: [
		self updateContentsExtent.
		self updateScrollbars.
		contentsChanged := false].

	super drawSubmorphsOn: (aCanvas copyClipRect: self innerBounds).
