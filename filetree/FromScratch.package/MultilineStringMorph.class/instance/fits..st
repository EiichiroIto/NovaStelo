private
fits: aString
	"Answer true if the given string fits within my width."

	| i |
	i := aString indexOf: Character cr.
	((i > 0) and: [i < aString size]) ifTrue: [^ false].  "line includes an embedded CR; needs to be broken"
	aString size > 500 ifTrue: [^ false].
	^ (renderer stringWidth: aString) < (self width - (self insetX + borderWidth + 2))
