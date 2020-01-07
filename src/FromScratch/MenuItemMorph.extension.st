Extension { #name : #MenuItemMorph }

{ #category : #'*FromScratch' }
MenuItemMorph >> localize [
	self contents: self contents localized
]
