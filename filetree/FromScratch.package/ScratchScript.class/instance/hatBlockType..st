blocks
hatBlockType: blockType
	| evtName subName |
	'E' = blockType
		ifTrue: [ evtName := ''.
			evtName := project defaultEventName.
			^ EventHatMorph new
				scriptOwner: self;
				eventName: evtName ].
	'G' = blockType
		ifTrue: [ ^ (EventHatMorph new for: 'when start' event: #start)
				scriptOwner: self ].
	'S' = blockType
		ifTrue: [ ^ EventHatMorph new forSetupEvent scriptOwner: self ].
	'T' = blockType
		ifTrue: [ ^ EventHatMorph new forStartupEvent scriptOwner: self ].
	'L' = blockType
		ifTrue: [ ^ EventHatMorph new forLoopEvent scriptOwner: self ].
	'C' = blockType
		ifTrue: [ subName := ''.
			subName := project defaultSubName.
			^ SubHatMorph new
				scriptOwner: self;
				subName: subName ]