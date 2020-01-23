accessing
defaultEventName
	| evtNames |
	evtNames := self allEventNames.
	^ evtNames isEmpty
		ifTrue: [ '' ]
		ifFalse: [ evtNames first ]