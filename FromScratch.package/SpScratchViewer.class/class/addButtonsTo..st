private
addButtonsTo: aLayout
	| w |
	w := SpScratchFrame viewerPaneWidth // 2.
	self buttons
		pairsDo: [ :each1 :each2 | 
			aLayout
				add:
					(SpBoxLayout newHorizontal
						add: each1 first withConstraints: [ :c | c width: w ];
						add: each2 first withConstraints: [ :c | c width: w ];
						yourself)
				withConstraints: [ :c | c height: self buttonHeight ] ]