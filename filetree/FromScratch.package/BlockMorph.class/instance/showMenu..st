private
showMenu: anEvent
	self project ifNotNil: [ :p | p application showBlockMenu: self event: anEvent ]