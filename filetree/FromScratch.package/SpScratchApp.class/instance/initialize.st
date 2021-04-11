initialization
initialize
	self class loadSettings.
	ScratchTranslator setLocale: self class language.
	super initialize.
	presenter := self newPresenter