private
addBlockMenu: aMenu for: aBlockMorph
	aMenu
		addGroup: [ :grp | 
			grp
				addItem: [ :item | 
					item
						name: 'copy';
						action: [ application copyBlock: aBlockMorph ] ];
				addItem: [ :item | 
					item
						name: 'cut';
						action: [ application cutBlock: aBlockMorph ] ] ];
		addGroup: [ :grp | 
			grp
				addItem: [ :item | 
					item
						name: 'delete';
						action: [ aBlockMorph delete ] ];
				addItem: [ :item | 
					item
						name: 'duplicate';
						action: [ application duplicateBlock: aBlockMorph ] ] ]