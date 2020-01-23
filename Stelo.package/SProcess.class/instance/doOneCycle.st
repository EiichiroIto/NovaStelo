execution
doOneCycle
	runningEvents
		do: [ :eventNo | 
			| eventCodes |
			eventCodes := program forEventNo: eventNo.
			eventCodes isEmpty
				ifFalse: [ self
						executeEventCodes: eventCodes
						ifTerminatedDo: [ self stop.
							^ false ] ] ].
	^ false