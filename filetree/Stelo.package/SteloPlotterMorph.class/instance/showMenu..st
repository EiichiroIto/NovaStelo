event handling
showMenu: anEvent
	| m |
	(m := self project) ifNil: [ ^ self ].
	m application currentTarget
		ifNotNil: [ :s | self showMenu: anEvent script: s ]