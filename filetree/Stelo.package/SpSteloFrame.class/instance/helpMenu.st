private
helpMenu
	^ self newMenu
		addItem: [ :item | 
			item
				name: ('About ' , application appName)  localized;
				action: [ owner window showAbout ] ];
		addItem: [ :item | 
			item
				name: 'Restart' localized;
				action: [ stageFrame startStepping ] ];
		addItem: [ :item | 
			item
				name: 'Inspect' localized;
				action: [ application inspect ] ];
		addItem: [ :item | 
			menuChangeWorld := item.
			item
				name: 'Change world' localized;
				action: [ application toggleSWorld ];
				enabled: [ self isPluginAvailable ];
				autoRefresh: true ];
		addItem: [ :item | 
			item
				name: 'Settings' localized;
				subMenu: self settingsMenu ];
		yourself