*FromScratch
localize
	self menuItems
		do: [ :each | 
			(each isKindOf: MenuItemMorph)
				ifTrue: [ each localize ] ]