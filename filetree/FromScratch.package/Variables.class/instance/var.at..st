accessing
var: anInteger at: id
	id = 0
		ifTrue: [ ^ 0 ].
	^ (self varAt: anInteger asInteger) at: id