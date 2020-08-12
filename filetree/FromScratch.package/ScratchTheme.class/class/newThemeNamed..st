instance creation
newThemeNamed: aString
	| obj |
	obj := self new.
	self readForms: aString to: obj.
	^ obj