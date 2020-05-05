private
settingsMenu
	| appClass m |
	appClass := self application class.
	m := self newMenu.
	m
		addGroup: [ :grp | 
			appClass settings keys sort
				do: [ :key | 
					grp
						addItem: [ :item | 
							item
								name: [ key , ' = ' , (appClass perform: key) asString ];
								autoRefresh: true;
								action: [ self selectSetting: key ] ] ] ].
	m
		addGroup: [ :grp | 
			grp
				addItem: [ :item | 
					item
						name: 'Save settings';
						action: [ appClass saveSettings ] ] ].
	^ m