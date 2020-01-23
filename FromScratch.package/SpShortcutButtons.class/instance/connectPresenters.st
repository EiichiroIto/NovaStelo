initialization
connectPresenters
	buttonComputer action: [ self setDirectoryType: #computer ].
	buttonUser action: [ self setDirectoryType: #user ].
	buttonDesktop action: [ self setDirectoryType: #desktop ].
	buttonExamples action: [ self setDirectoryType: #examples ].
	buttonProjects action: [ self setDirectoryType: #project ]