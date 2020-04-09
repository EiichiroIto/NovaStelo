initialization
initialize
	self class loadSettings.
	super initialize.
	presenter := self newPresenter.
	updateInfoCount := 0