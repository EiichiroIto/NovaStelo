private
eventTitleString: aString
	aString isEmpty ifTrue: [ ^ nil ].
	^ targetMorph project eventIdFor: aString asSymbol