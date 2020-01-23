observer ops
createTurtles
	| count bid |
	bid := self pop.
	count := self pop.
	world create: bid asInteger turtles: count asInteger.