private
selectTurtlesMenu
	| menu |
	menu := self newMenu.
	turtles
		do: [ :each | 
			menu
				addItem: [ :item | 
					item
						name: each objName;
						action: [ self turtlesSelected: each breedNo ] ] ].
	^ menu