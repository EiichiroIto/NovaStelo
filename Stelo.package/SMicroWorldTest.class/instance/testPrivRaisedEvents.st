tests-private
testPrivRaisedEvents
	| w |
	w := SMicroWorld new.
	self assert: w privRaisedEvents isEmpty.
	w privRaisedEvents: #(1 2 3).
	self assertCollection: w privRaisedEvents equals: #(1 2 3).
	w privRaisedEvents: #(4 5 6).
	self assertCollection: w privRaisedEvents equals: #(4 5 6).