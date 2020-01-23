drawing-optimization
updateCachedForm
	"Create a cached Form of this stack's appearance."

	| c |
	oldColor ifNotNil: [ color := oldColor ].
	c := FormCanvas extent: self fullBounds extent depth: 32.
	c := c copyOffset: self topLeft negated.
	self drawOn: c.
	self drawSubmorphsOn: c.
	cachedForm := c form.
	lastLayoutTime := Time millisecondClockValue