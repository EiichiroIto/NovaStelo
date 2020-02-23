event handling
showMenu: anEvent
	| m |
	(m := self project) ifNil: [ ^ self ].
	m application target
		ifNotNil: [ :s | self scriptsMenu: anEvent script: s ]