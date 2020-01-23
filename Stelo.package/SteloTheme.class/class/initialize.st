class initialization
initialize
	self themeIsInstalled
		ifFalse: [ (self confirm: 'Get themes from github.com?')
				ifFalse: [ ^ self ] ].
	self setupTheme