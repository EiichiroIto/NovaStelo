accessing
blockMenuFor: aBlockMorph inScriptEditor: aBoolean
	| menu |
	aBoolean
		ifFalse: [ ^ nil ].
	menu := self newMenu.
	self addBlockMenu: menu for: aBlockMorph.
	^ menu