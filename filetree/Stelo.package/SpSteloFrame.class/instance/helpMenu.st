private
helpMenu
	^ self newMenu
		addItem: [ :item | 
			item
				name: 'About ' , application appName;
				action: [ owner window showAbout ] ];
		addItem: [ :item | 
			item
				name: 'Restart';
				action: [ stageFrame startStepping ] ];
		addItem: [ :item | 
			item
				name: 'Inspect';
				action: [ application inspect ] ];
		addItem: [ :item | 
			menuChangeWorld := item.
			item
				name: 'Change world';
				action: [ application toggleSWorld ];
				enabled: [ self isPluginAvailable ];
				autoRefresh: true ];
		addItem: [ :item | 
			item
				name: 'Settings';
				subMenu: self settingsMenu ];
		yourself