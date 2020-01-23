*FromScratch
shapeFillGradientFrom: fromColor to: toColor at: aPoint type: aSymbol
	"Fill the area of similar colors around the given point with a gradient of the given type."

	| mapDepth maskForm map r newForm c |
	mapDepth := 9.	"can be 9 or 12"
	depth = 1
		ifTrue: [ ^ self oneBitShapeFill: fromColor interiorPoint: aPoint ].	"map this form into a B/W mask form with 0's in areas of matching color"
	maskForm := Form extent: self extent depth: 1.
	map := Bitmap new: (1 bitShift: (depth min: mapDepth)) withAll: 1.
	depth <= 8
		ifTrue: [ map at: (self pixelValueAt: aPoint) + 1 put: 0 ]
		ifFalse: [ 
			c := self colorNoAlphaAt: aPoint.
			map at: (c pixelValueForDepth: mapDepth) + 1 put: 0 ].
	maskForm
		copyBits: self boundingBox
		from: self
		at: 0 @ 0
		colorMap: map.	"now fill the shape"
	maskForm := maskForm findShapeAroundSeedBlock: [ :form | form pixelValueAt: aPoint put: 1 ].
	r := maskForm rectangleEnclosingPixelsNotOfColor: Color white.
	r area = 0
		ifTrue: [ ^ self ].	"zero width or height"
	newForm := Form extent: r extent depth: 32.
	aSymbol = #radial
		ifTrue: [ newForm fillRadialFromXColorBlock: [ :m | toColor mixed: m with: fromColor ] center: aPoint - r origin ]
		ifFalse: [ 
			aSymbol = #horizontal
				ifTrue: [ newForm fillFromXColorBlock: [ :m | toColor mixed: m with: fromColor ] ]
				ifFalse: [ newForm fillFromYColorBlock: [ :m | toColor mixed: m with: fromColor ] ] ].	"use the mask to cut out the shape"
	((BitBlt
		destForm: newForm
		sourceForm: maskForm
		fillColor: nil
		combinationRule: Form erase1bitShape
		destOrigin: maskForm offset
		sourceOrigin: r origin
		extent: self extent
		clipRect: self boundingBox) colorMap: (Bitmap with: 16rFFFFFFFF with: 0)) copyBits.	"Cut a hole in the picture with my mask"	"copy the masked gradient shape into myself"
	self
		copy: newForm boundingBox
		from: newForm
		to: r origin
		rule: Form paint