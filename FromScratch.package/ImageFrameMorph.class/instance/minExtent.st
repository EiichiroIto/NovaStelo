accessing
minExtent
	"Answer my minimum extent."

	^ (topLeftForm width + topEdgeForm width + topRightForm width) @
	  (topLeftForm height + leftEdgeForm height + bottomLeftForm height)