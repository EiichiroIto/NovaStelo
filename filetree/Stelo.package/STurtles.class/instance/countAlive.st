microworld
countAlive
	| ret |
	ret := 0.
	self livingOnesDo: [ :each | ret := ret + 1 ].
	^ ret