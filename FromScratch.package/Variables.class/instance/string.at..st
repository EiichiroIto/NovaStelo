accessing
string: anInteger at: id
	id = 0
		ifTrue: [ ^ 0 ].
	^ (self varAt: anInteger asInteger) stringAt: id