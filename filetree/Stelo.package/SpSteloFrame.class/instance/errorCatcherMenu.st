private
errorCatcherMenu
	^ self newMenu
		addItem: [ :item | 
			item
				name: 'enable';
				action: [ application class useErrorCatcher: false ];
				enabled: [ application class useErrorCatcher ] ];
		addItem: [ :item | 
			item
				name: 'disable';
				action: [ application class useErrorCatcher: true ];
				enabled: [ application class useErrorCatcher not ] ];
		yourself