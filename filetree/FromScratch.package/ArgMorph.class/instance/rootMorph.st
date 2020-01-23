accessing
rootMorph
	owner ifNil: [ ^ self ].
	^ self rootMorph