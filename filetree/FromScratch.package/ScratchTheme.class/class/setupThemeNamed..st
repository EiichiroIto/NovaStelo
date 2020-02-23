private
setupThemeNamed: aString
	| obj |
	self themeIsInstalled
		ifFalse: [ self getThemes ].
	obj := self newThemeNamed: aString.
	self setupThemeColor: obj.
	self current: obj