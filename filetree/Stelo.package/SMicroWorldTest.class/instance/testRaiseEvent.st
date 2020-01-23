tests-accessing
testRaiseEvent
	| w |
	w := SMicroWorld new.
	self assert: w privRaisedEvents isEmpty.
	w raiseEvent: #a.
	self assertCollection: w privRaisedEvents asArray equals: #(a).
	w raiseEvent: #b.
	self assert: w privRaisedEvents size equals: 2.
	self assert: (w privRaisedEvents includes: #a).
	self assert: (w privRaisedEvents includes: #b).