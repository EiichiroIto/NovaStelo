event handling
presentMenu
	"Let the user select a Scratch object or the special value #mouse."

	| project objList menu choice |
	(project := self project) ifNil: [^ self].

	"(owner isKindOf: CommandBlockMorph) ifTrue: [sel := owner selector]."

	objList := project scriptsForMenu.
	objList sort: [:obj1 :obj2 | obj1 objName asLowercase < obj2 objName asLowercase].

	menu := MenuMorph new.
	menu target: [ :v | choice := v ].
	"sel = #getAttribute:of:
		ifTrue: [
			menu add: ('Stage' localized) selector: #value: argument: frame workPane]
		ifFalse: [
			menu add: 'mouse-pointer' localized selector: #value: argument: #mouse.
			sel = #touching: ifTrue: [menu add: 'edge' localized selector: #value: argument: #edge].
			objList := objList copyWithout: owner receiver]."

	objList size > 0 ifTrue: [menu addLine].
	objList do: [:obj | menu add: obj objName selector: #value: argument: obj].

	menu invokeAt: ActiveHand position in: self world.
	choice ifNil: [^ self].
	morph := choice.
	"self fixGetAttribueBlock."
	self updateLabel.
