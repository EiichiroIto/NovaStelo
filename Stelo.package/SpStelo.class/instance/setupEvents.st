processes
setupEvents
	| result eventId |
	eventId := EventId new.
	result := Dictionary new.
	result at: #startup put: EventId startupEventNo.
	result at: #setup put: EventId setupEventNo.
	result at: #loop put: EventId loopEventNo.
	result at: #single put: EventId singleEventNo.
	project allEventNames do: [ :each | result at: each asSymbol put: eventId newNo ].
	events := result.
	^ events