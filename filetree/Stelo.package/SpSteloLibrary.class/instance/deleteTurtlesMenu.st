private
deleteTurtlesMenu
	| menu |
	menu := self newMenu.
	turtles
		do: [ :each | 
			menu
				addItem: [ :item | 
					item
						name: each objName;
						action: [ self turtlesDeleted: each breedNo ] ] ].
	^ menu