class initialization
initialize
	"SteloTheme initialize."
	self themeIsInstalled
		ifFalse: [ (self confirm: 'Get themes from github.com?')
				ifFalse: [ ^ self ] ].
	self setupThemeNamed: SpStelo appFolderName