initialization
connectPresenters
	listEntries
		display: [ :m | self showEntry: m ];
		whenActivatedDo: [ :selection | self entriesChanged: selection ].
	listHierarchy
		whenSelectedItemChangedDo: [ :selection | self currentChanged: selection ].
	buttonParent action: [ self changeParentDirectory ].
	buttonNew action: [ self newFolder ]