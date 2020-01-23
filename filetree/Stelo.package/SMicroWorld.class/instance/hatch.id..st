command
hatch: bid id: anInteger
	| list |
	list := self create: bid turtles: 1.
	list do: [ :each | (breeds at: bid) copyTurtleFrom: anInteger to: each ].