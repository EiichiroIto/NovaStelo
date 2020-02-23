instance creation
newThemeNamed: aString
	| obj |
	obj := self new.
	self setupFont: obj.
	self readForms: aString to: obj.
	^ obj