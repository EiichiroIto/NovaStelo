tests-private
testSetupSelector
	| d |
	d := SDiffuser neighbor4.
	self assert: d setupSelector equals: #setupNeighbor4.
	d setupSelector: #abc.
	self assert: d setupSelector equals: #abc.
	d := SDiffuser neighbor8.
	self assert: d setupSelector equals: #setupNeighbor8.