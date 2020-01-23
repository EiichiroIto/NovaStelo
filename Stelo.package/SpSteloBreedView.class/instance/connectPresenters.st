initialization
connectPresenters
	buttonDelete action: [ self delete ].
	buttonRefresh action: [ self updateTable ]