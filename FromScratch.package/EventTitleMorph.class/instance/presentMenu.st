event handling
presentMenu
	"Pop up a menu of choices."

	| eventNames project menu choice s |
	eventNames := #().
	(project := self project)
		ifNotNil: [ eventNames := project allEventNames ].
	menu := MenuMorph new.
	menu target: [ :v | choice := v ].
	eventNames
		do: [ :n | menu add: n selector: #value: argument: n asString ].
	menu addLine.
	menu
		add: 'new' localized , ScratchTranslator ellipsesSuffix
		selector: #value:
		argument: #newEvent.
	menu invokeAt: ActiveHand position in: self world.
	choice ifNil: [ ^ self ].
	choice == #newEvent
		ifTrue: [ s := UIManager default request: 'Message name:'.
			(s isNil or: [ s isEmpty ])
				ifTrue: [ ^ self ].
			^ self eventName: s ].
	self eventName: choice