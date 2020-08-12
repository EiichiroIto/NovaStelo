private
addBlockMenu: aMenu for: aBlockMorph
	aMenu
		addGroup: [ :grp | 
			grp
				addItem: [ :item | 
					item
						name: 'copy' localized;
						action: [ application copyBlock: aBlockMorph ] ];
				addItem: [ :item | 
					item
						name: 'cut' localized;
						action: [ application cutBlock: aBlockMorph ] ] ];
		addGroup: [ :grp | 
			grp
				addItem: [ :item | 
					item
						name: 'delete' localized;
						action: [ aBlockMorph delete ] ];
				addItem: [ :item | 
					item
						name: 'duplicate' localized;
						action: [ application duplicateBlock: aBlockMorph ] ] ]