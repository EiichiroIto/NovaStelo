instance creation
newThemeNamed: aString
	| obj |
	obj := ScratchTheme new.
	self setupFont: obj.
	self readForms: aString to: obj.
	^ obj