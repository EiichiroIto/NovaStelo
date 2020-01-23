menu actions
toggleSWorld
	sworldMode = #SMicroWorld
		ifTrue: [ self changePluginWorld ]
		ifFalse: [ self changeMicroWorld ].
	presenter sworldMode: sworldMode.
	self updateStatus