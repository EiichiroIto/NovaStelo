Extension { #name : #InputEventSensor }

{ #category : #'*FromScratch' }
InputEventSensor >> peekAnyButtonPressed [
	^ self peekMouseButtons anyMask: 7
]

{ #category : #'*FromScratch' }
InputEventSensor >> peekMouseButtons [
	| evt |
	evt := eventQueue peek.
	^ (evt notNil and: [ (evt at: 1) = EventTypeMouse ])
		ifTrue: [ evt at: 3 ]
		ifFalse: [ mouseButtons ]
]
