private
helpMenu
	^ self newMenu
		addItem: [ :item | 
			item
				name: 'About ' , application appName;
				action: [ owner window showAbout ] ];
		addItem: [ :item | 
			menuChangeWorld := item.
			item
				name: 'Change world';
				action: [ application toggleSWorld ];
				enabled: [ self isPluginAvailable ];
				autoRefresh: true ];
		addItem: [ :item | 
			item
				name: 'Error Catcher';
				subMenu: self errorCatcherMenu ];
		yourself