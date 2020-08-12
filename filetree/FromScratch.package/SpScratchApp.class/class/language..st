accessing
language: aString
	| old |
	old := self language.
	(ScratchTranslator setLocale: aString)
		ifFalse: [ ^ self ].
	self settings at: #language put: aString.
	old = aString
		ifTrue: [ ^ self ].
	(self confirm: 'Language settings has changed. Restart application?')
		ifFalse: [ ^ self ].
	self saveSettings.
	Smalltalk snapshot: false andQuit: true