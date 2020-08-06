class initialization
initialize
	"self initialize"
	ScratchDirectory current appName: self appFolderName.
	ScratchTheme
		themesURL: self themesURL;
		setupThemeNamed: self appFolderName