*FromScratch
shapeFill: aColor interiorPoint: aPoint
	"Fill the area of similar colors around the given point with the given solid color."

	| mapDepth maskForm map c bb |
	mapDepth := 9.  "can be 9 or 12"
	depth = 1 ifTrue: [^ self oneBitShapeFill: aColor interiorPoint: aPoint].

	"map this form into a B/W mask form with 0's in areas of matching color"
	maskForm := Form extent: self extent depth: 1.
	map := Bitmap new: (1 bitShift: (depth min: mapDepth)) withAll: 1.
	depth <= 8
		ifTrue: [
			map at: (self pixelValueAt: aPoint) + 1 put: 0]
		ifFalse: [
			c := self colorNoAlphaAt: aPoint.
			map at: (c pixelValueForDepth: mapDepth) + 1 put: 0].
	maskForm copyBits: self boundingBox from: self at: 0@0 colorMap: map.

	"now fill the shape in the mask"
	maskForm := maskForm findShapeAroundSeedBlock: [:f | f pixelValueAt: aPoint put: 1].

	"use mask to fill with solid color"
	bb := (BitBlt toForm: self)
		destOrigin: 0@0;
		sourceForm: maskForm;
		sourceRect: maskForm boundingBox;
		colorMap: (Bitmap with: 0 with: 16rFFFFFFFF).

	aColor isTransparent
		ifTrue: [bb combinationRule: Form erase1bitShape; copyBits]
		ifFalse: [bb fillColor: aColor; combinationRule: Form paint; copyBits].

	^ maskForm
