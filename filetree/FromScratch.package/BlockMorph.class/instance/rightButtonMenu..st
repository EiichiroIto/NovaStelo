event handling
rightButtonMenu: anEvent
	| menu |
	owner isBlockPalette
		ifTrue: [ ^ self ].
	owner isBlockMorph
		ifTrue: [ ^ self ].
	menu := MenuMorph new.
	menu target: self.
	menu add: 'delete' selector: #delete.
	menu localize.
	menu popUpEvent: anEvent in: self world