event handling
mouseDown: evt
	| rcvr list choice ret |
	menuMorph ifNil: [ ^ super mouseDown: evt ].
	evt cursorPoint x < (menuMorph left - 1)
		ifTrue: [ ^ super mouseDown: evt ].
	rcvr := self getOptionsTarget.
	rcvr ifNil: [ rcvr := owner receiver ].
	(self getOptionsSelector isNil or: [ rcvr isNil ])
		ifTrue: [ ^ self beep ].
	list := rcvr perform: self getOptionsSelector.
	list isEmpty
		ifTrue: [ ^ self ].
	ret := UIManager default chooseFrom: (list collect: #first).
	ret = 0
		ifTrue: [ ^ self ].
	choice := (list at: ret) second.
	evt hand newKeyboardFocus: nil.
	(#(listIndexNames listIndexForDeleteNames) includes: getOptionsSelector)
		ifTrue: [ ^ self specialValue: choice ].
	isNumber
		ifTrue: [ self numExpression: choice ]
		ifFalse: [ self stringExpression: choice ]