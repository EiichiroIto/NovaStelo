event handling
showMenu: anEvent
	self project
		ifNotNil:
			[ :p | p application showScriptMenu: p application target event: anEvent ]