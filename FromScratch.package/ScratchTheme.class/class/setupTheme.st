initialization
setupTheme
	self themeIsInstalled
		ifFalse: [ self getThemes ].
	self setupAvailableThemes.
	self changeTheme: AvailableThemes keys anyOne