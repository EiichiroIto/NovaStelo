accessing
blockMenuFor: aBlockMorph inScriptEditor: aBoolean
	| menu |
	aBoolean
		ifFalse: [ ^ self ].
	menu := self newMenu.
	self addBlockMenu: menu for: aBlockMorph.
	^ menu