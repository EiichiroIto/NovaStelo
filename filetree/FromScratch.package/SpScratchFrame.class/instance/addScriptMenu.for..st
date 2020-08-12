private
addScriptMenu: aMenu for: aScript
	SpScratchApp clipboard isString
		ifTrue: [ aMenu
				addItem: [ :item | 
					item
						name: 'paste' localized;
						action: [ application pasteBlock ] ] ].
	aMenu
		addGroup: [ :grp | 
			grp
				addItem: [ :item | 
					item
						name: 'add sub block' localized;
						action: [ application addSubBlock: ActiveHand cursorPoint script: aScript ] ] ];
		addGroup: [ :grp | 
			grp
				addItem: [ :item | 
					item
						name: 'clean up' localized;
						action: [ aScript cleanUp ] ];
				addItem: [ :item | 
					item
						name: 'save picture of scripts' localized;
						action: [ application saveScriptsToImage ] ] ]