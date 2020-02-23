accessing
open
	self class loadOptions.
	self open: presenter.
	self newProject.
	presenter window maximize.
	^ self