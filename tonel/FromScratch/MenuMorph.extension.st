Extension { #name : #MenuMorph }

{ #category : #'*FromScratch' }
MenuMorph >> localize [
	self menuItems
		do: [ :each | 
			(each isKindOf: MenuItemMorph)
				ifTrue: [ each localize ] ]
]

{ #category : #'*FromScratch' }
MenuMorph >> updateTarget: anObject [
	self items do: [ :each | each target ifNil: [ each target: anObject ] ]
]
