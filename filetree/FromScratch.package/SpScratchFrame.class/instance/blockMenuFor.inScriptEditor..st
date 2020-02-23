private
blockMenuFor: aBlockMorph inScriptEditor: aBoolean
	aBoolean
		ifFalse: [ ^ self ].
	^ self newMenu
		addGroup: [ :grp | 
			grp
				addItem: [ :item | 
					item
						name: 'delete';
						action: [ aBlockMorph delete ] ];
				addItem: [ :item | 
					item
						name: 'duplicate';
						action: [ application duplicateBlock: aBlockMorph ] ] ];
		yourself