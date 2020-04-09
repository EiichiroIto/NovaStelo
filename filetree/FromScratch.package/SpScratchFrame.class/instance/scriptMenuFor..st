accessing
scriptMenuFor: aScript
	| menu |
	menu := self newMenu.
	self addScriptMenu: menu for: aScript.
	^ menu