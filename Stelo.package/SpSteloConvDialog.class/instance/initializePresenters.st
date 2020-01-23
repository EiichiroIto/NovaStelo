initialization
initializePresenters
	dropListNames := self newDropList.
	dropPlots := self newDropList.
	labelListNames := self newLabel.
	labelPlots := self newLabel.
	labelListNames label: 'list names' translated.
	labelPlots label: 'plot numbers' translated.
	self focusOrder
		add: dropListNames;
		add: dropPlots