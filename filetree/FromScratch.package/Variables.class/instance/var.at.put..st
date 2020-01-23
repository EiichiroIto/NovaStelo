accessing
var: anInteger at: id put: anObject
	id = 0
		ifTrue: [ ^ self ].
	(self varAt: anInteger asInteger) at: id put: anObject.