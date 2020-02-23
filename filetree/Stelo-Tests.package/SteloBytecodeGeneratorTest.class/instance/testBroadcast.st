test
testBroadcast
	| w b t e eventId |
	w := self newWorld.
	w create: 3 turtles: 1.
	eventId := EventId new.
	e := eventId newNo.
	b := self newGenerator.
	b broadcast: e.
	self assert: w raisedEvents isEmpty.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self assert: (w raisedEvents includes: e).