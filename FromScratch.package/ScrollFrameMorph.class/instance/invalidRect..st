geometry
invalidRect: damageRect
	"Clip damage reports to my bounds, since drawing is clipped to my bounds."

	| r |
	r := damageRect intersect: self bounds.
	(r width > 0 and: [r height > 0]) ifTrue: [super invalidRect: r].
