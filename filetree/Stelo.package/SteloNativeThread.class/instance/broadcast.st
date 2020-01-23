misc ops
broadcast
	| eventId |
	eventId := self pop.
	world raiseEvent: eventId asInteger.