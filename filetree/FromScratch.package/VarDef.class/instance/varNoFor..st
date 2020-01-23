accessing
varNoFor: aString
	aString isEmpty ifTrue: [ ^ nil ].
	(self includes: aString)
		ifFalse: [ ^ NotFound signalFor: self ].
	^ varNames indexOf: aString