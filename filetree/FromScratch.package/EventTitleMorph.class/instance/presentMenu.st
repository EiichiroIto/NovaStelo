event handling
presentMenu
	"Pop up a menu of choices."

	| eventNames ret choice |
	eventNames := {('new' localized , ScratchTranslator ellipsesSuffix)}.
	self project
		ifNotNil: [ :project | eventNames := eventNames , project allEventNames ].
	ret := UIManager default chooseFrom: eventNames lines: #(1).
	ret = 0
		ifTrue: [ ^ self ].
	choice := eventNames at: ret.
	ret = 1
		ifTrue: [ choice := UIManager default request: 'Message name:' localized.
			(choice isNil or: [ choice isEmpty ])
				ifTrue: [ ^ self ] ].
	self eventName: choice

	"menu := MenuMorph new.
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
	self eventName: choice"