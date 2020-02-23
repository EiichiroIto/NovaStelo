accessing
eventMenuFrom: aDictionary whenSelected: aBlock
	| m list |
	m := self newMenu.
	list := aDictionary keys.
	list := list copyWithoutAll: #(#startup #setup #loop #single).
	list isEmpty
		ifTrue: [ ^ nil ].
	list sorted
		do: [ :each | 
			m
				addItem: [ :item | 
					item
						name: each;
						action: [ aBlock cull: (aDictionary at: each) ] ] ].
	^ m