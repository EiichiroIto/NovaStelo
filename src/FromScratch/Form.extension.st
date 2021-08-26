Extension { #name : #Form }

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
Form >> privateOffset [
	^ offset
]
