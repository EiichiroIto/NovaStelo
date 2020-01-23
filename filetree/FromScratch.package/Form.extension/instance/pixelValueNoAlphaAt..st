*FromScratch
pixelValueNoAlphaAt: aPoint 
	"Answer the raw pixel value at the given point. The pixel value depends on the receiver's depth. If the depth is 32 and the pixel is not transparent, ignore alpha."

	| pixel |
	depth < 32 ifTrue: [^ self pixelValueAt: aPoint].
	pixel := (BitBlt bitPeekerFromForm: self) pixelAt: aPoint.
	pixel > 0 ifTrue: [pixel := pixel bitOr: 16rFF000000].  "treat as opaque"
	^ pixel
