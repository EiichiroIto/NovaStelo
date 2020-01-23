samples
sample1
	"SMicroWorld sample1."

	| world d |
	world := SMicroWorld new.
	d := SDisplay sworld: world.
	world create: 10000 turtles: 2.
	"world turtlesDo: [ :ts :w :i | ts penDownAt: i put: true ].
	world turtlesDo: [ :ts :w :i | ts forward: 30 world: w at: i ]."
	d openInWorld.
	^ d.