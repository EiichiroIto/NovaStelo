tests-accessing
testClearRaisedEvents
	| w |
	w := SMicroWorld new.
	self assert: w privRaisedEvents isEmpty.
	w raiseEvent: #a.
	self assert: w privRaisedEvents notEmpty.
	w clearRaisedEvents.
	self assert: w privRaisedEvents isEmpty.