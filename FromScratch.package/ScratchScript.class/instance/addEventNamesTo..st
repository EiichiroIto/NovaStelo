accessing
addEventNamesTo: aSet
	"Add the names of all events implemented by this morph, excluding keyboard events. Suppress duplicates (ignoring case differences)."

	blocksBin isMorph
		ifFalse: [ ^ self ].
	blocksBin
		allMorphsDo: [ :m | 
			m class = EventTitleMorph
				ifTrue: [ (aSet anySatisfy: [ :el | (el compare: m eventName) = 2 ])
						ifFalse: [ aSet add: m eventName ] ] ]