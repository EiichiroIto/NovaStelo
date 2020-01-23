event handling
mouseDown: evt
	| rcvr menu choice ret |
	menuMorph ifNil: [ ^ super mouseDown: evt ].
	evt cursorPoint x < (menuMorph left - 1)
		ifTrue: [ ^ super mouseDown: evt ].
	(getMenuSelector notNil
		and: [ (owner isKindOf: BlockMorph) and: [ (rcvr := owner receiver) notNil ] ])
		ifFalse: [ ^ self beep ].
	menu := MenuMorph new.
	menu target: [ :v | choice := v ].
	(rcvr perform: getMenuSelector)
		do: [ :each | menu add: each first selector: #value: argument: each second ].
	menu invokeAt: ActiveHand position in: self world.
	choice ifNil: [ ^ self ].
	evt hand newKeyboardFocus: nil.	"close mini-editor, if any"
	"(#(listIndexMenu listIndexForDeleteMenu) includes: getMenuSelector)
		ifTrue: [ ^ self specialValue: choice ]."
	isNumber
		ifTrue: [ self numExpression: choice ]
		ifFalse: [ self stringExpression: choice ].