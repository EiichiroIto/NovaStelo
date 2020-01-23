blocks
hatBlockFromTuple: tuple receiver: scriptOwner
	| blockClass block eventName |
	blockClass := Smalltalk at: tuple first.
	block := blockClass new scriptOwner: scriptOwner.
	blockClass = EventHatMorph
		ifTrue: [ eventName := tuple at: 2.
			eventName = 'startup'
				ifTrue: [ block
						forStartupEvent;
						scriptOwner: scriptOwner.
					^ block ].
			eventName = 'setup'
				ifTrue: [ block
						forSetupEvent;
						scriptOwner: scriptOwner.
					^ block ].
			eventName = 'loop'
				ifTrue: [ block
						forLoopEvent;
						scriptOwner: scriptOwner.
					^ block ].
			block eventName: eventName.
			^ block ].
	blockClass = SubHatMorph
		ifTrue: [ block
				subName: (tuple at: 2);
				scriptOwner: scriptOwner.
			^ block ].
	^ block