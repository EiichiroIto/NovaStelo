Extension { #name : #MenuMorph }

{ #category : #'*FromScratch' }
MenuMorph >> localize [
	self menuItems
		do: [ :each | 
			(each isKindOf: MenuItemMorph)
				ifTrue: [ each localize ] ]
]
