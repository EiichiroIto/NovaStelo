scrolling
maxScroll
	"Answer a point representing the maximum horizontal and vertical scroll offsets in pixels."

	^ contents extent - self visibleExtent
