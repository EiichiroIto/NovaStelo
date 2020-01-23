*FromScratch
peekMouseButtons
	| evt |
	evt := eventQueue peek.
	^ (evt notNil and: [ (evt at: 1) = EventTypeMouse ])
		ifTrue: [ evt at: 3 ]
		ifFalse: [ mouseButtons ]