accessing
whenFileSelectedBlock: aBlock
	itemSelectedBlock := aBlock.
	itemSelectedBlock
		ifNotNil: [ listEntries whenSelectionChangedDo: itemSelectedBlock ]