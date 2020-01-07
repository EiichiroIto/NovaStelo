Extension { #name : #Form }

{ #category : #'*FromScratch' }
Form >> colorNoAlphaAt: aPoint [
	"Answer the color in the pixel at the given point, ignoring alpha."

	^ Color colorFromPixelValue: (self pixelValueNoAlphaAt: aPoint) depth: depth

]

{ #category : #'*FromScratch' }
Form >> couldBeColorReduced [
	"Answer true if this Form has few enough colors to be converted to a ColorForm, but answer false if quantizing it's colors in the process of creating the ColorForm would result in fewer colors than the original. (Note: Converting to a ColorForm may still result in small color shifts due to color quantization, buf if all the colors remain unique these shifts should not be too noticable.)"

	| colors pixel |
	self depth < 32 ifTrue: [^ false].
	self unhibernate.
	colors := Set new: 1000.
	1 to: bits size do: [:i |
		pixel := (bits at: i) bitAnd: 16rFFFFFF.
		pixel = 0 ifFalse: [
			colors add: pixel.
			colors size > 255 ifTrue: [^ false]]].

	^ colors size <= self colorsUsed size

]

{ #category : #'*FromScratch' }
Form >> equals: aForm [
	"Answer true if the receiver is exactly the same as the given Form."

	self == aForm ifTrue: [^ true].

	self class = aForm class ifFalse: [^ false].
	self class = ColorForm ifTrue: [
		self colors = aForm colors  ifFalse: [^ false]].
	(width = aForm width) & (height = aForm height) ifFalse: [^ false].
	(depth = aForm depth) & (offset = aForm privateOffset) ifFalse: [^ false].

	bits class = aForm bits class ifFalse: [
		self hibernate.
		aForm hibernate].
	^ bits = aForm bits
]

{ #category : #'*FromScratch' }
Form >> fillRadialFromXColorBlock: colorBlock center: aPoint [
	"Horizontal Gradient Fill. Supply relative x in [0.0 ... 1.0] to colorBlock, and paint each pixel with the color that comes back."

	| canvas m div t |
	canvas := self getCanvas.
	self fill: self boundingBox fillColor: (colorBlock value: 1).
	m := width max: height.
	m > 1
		ifFalse: [ ^ self ].
	div := (m - 1) asFloat.
	(m - 1) negated to: 0 do: [ :x | 
		t := x abs.
		canvas frameOval: (Rectangle center: aPoint extent: t @ t) color: (colorBlock value: t asFloat / div) ]
]

{ #category : #'*FromScratch' }
Form >> findShapeAroundSeedBlock: seedBlock [
	"Build a shape that is black in any region marked by seedBlock. 
	SeedBlock will be supplied a form, in which to blacken various
	pixels as 'seeds'.  Then the seeds are smeared until 
	there is no change in the smear when it fills the region, ie,
	when smearing hits a black border and thus goes no further."
	| smearForm previousSmear all count smearPort |
	self assert: [self depth = 1]. "Only meaningful for B/W forms."
	all := self boundingBox.
	smearForm := Form extent: self extent.
	smearPort := BitBlt toForm: smearForm.
	seedBlock value: smearForm.		"Blacken seeds to be smeared"
	smearPort copyForm: self to: 0 @ 0 rule: Form erase.  "Clear any in black"
	previousSmear := smearForm deepCopy.
	count := 1.
	[count = 10 and:   "check for no change every 10 smears"
		[count := 1.
		previousSmear copy: all from: 0 @ 0 in: smearForm rule: Form reverse.
		previousSmear isAllWhite]]
		whileFalse: 
			[smearPort copyForm: smearForm to: 1 @ 0 rule: Form under.
			smearPort copyForm: smearForm to: -1 @ 0 rule: Form under.
			"After horiz smear, trim around the region border"
			smearPort copyForm: self to: 0 @ 0 rule: Form erase.
			smearPort copyForm: smearForm to: 0 @ 1 rule: Form under.
			smearPort copyForm: smearForm to: 0 @ -1 rule: Form under.
			"After vert smear, trim around the region border"
			smearPort copyForm: self to: 0 @ 0 rule: Form erase.
			count := count+1.
			count = 9 ifTrue: "Save penultimate smear for comparison"
				[previousSmear copy: all from: 0 @ 0 in: smearForm rule: Form over]].
	"Now paint the filled region in me with aHalftone"
	^ smearForm
]

{ #category : #'*FromScratch' }
Form >> oneBitShapeFill: aColor interiorPoint: aPoint [

	depth > 1 ifTrue: [self error: 'This call only meaningful for 1-bit forms'].

	(self findShapeAroundSeedBlock: [:f | f pixelValueAt: aPoint put: 1])
		displayOn: self
		at: 0@0
		clippingBox: self boundingBox
		rule: Form under
		fillColor: aColor.

]

{ #category : #'*FromScratch' }
Form >> outlineWidth: w color: outlineColor depth: resultDepth [
	"Answer a Form containing the outline of this Form."

	| mask cm outline neg result |
	"make a mask form with black for all non-transparent pixels"
	mask := Form extent: (self extent + w + w) depth: 2.
	cm := self newColorMap.
	cm atAllPut: (Color black pixelValueForDepth: mask depth).
	cm at: 1 put: 0.
	mask copyBits: self boundingBox from: self at: w@w colorMap: cm.

	"stamp the mask form onto a new form at various offsets"
	outline := Form extent: mask extent depth: mask depth.
	1 to: w do: [:pos |
		neg := pos negated.
		mask displayOn: outline at: pos@0 rule: Form paint.
		mask displayOn: outline at: neg@0 rule: Form paint.
		mask displayOn: outline at: 0@pos rule: Form paint.
		mask displayOn: outline at: 0@neg rule: Form paint.
		mask displayOn: outline at: pos@pos rule: Form paint.
		mask displayOn: outline at: pos@neg rule: Form paint.
		mask displayOn: outline at: neg@pos rule: Form paint.
		mask displayOn: outline at: neg@neg rule: Form paint].

	"cut out a hole with the original form"
	mask displayOn: outline at: 0@0 rule: Form erase.

	"copy the outline in the desired color onto the result form"
	result := Form extent: mask extent depth: resultDepth.
	cm := outline newColorMap.
	cm
		at: (Color black pixelValueForDepth: outline depth) + 1
		put: (outlineColor pixelValueForDepth: result depth).
	result copyBits: outline boundingBox from: outline at: 0@0 colorMap: cm.
	^ result

]

{ #category : #'*FromScratch' }
Form >> pixelValueNoAlphaAt: aPoint [ 
	"Answer the raw pixel value at the given point. The pixel value depends on the receiver's depth. If the depth is 32 and the pixel is not transparent, ignore alpha."

	| pixel |
	depth < 32 ifTrue: [^ self pixelValueAt: aPoint].
	pixel := (BitBlt bitPeekerFromForm: self) pixelAt: aPoint.
	pixel > 0 ifTrue: [pixel := pixel bitOr: 16rFF000000].  "treat as opaque"
	^ pixel

]

{ #category : #'*FromScratch' }
Form >> privateOffset [
	^ offset
]

{ #category : #'*FromScratch' }
Form >> shapeFill: aColor interiorPoint: aPoint [
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

]

{ #category : #'*FromScratch' }
Form >> shapeFillGradientFrom: fromColor to: toColor at: aPoint type: aSymbol [
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
]
