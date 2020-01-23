private
updateDarkTheme
	"ScratchTheme updateDarkTheme."
	AvailableThemes at: #darkTheme put: self buildDarkTheme.
	self changeTheme: #darkTheme.