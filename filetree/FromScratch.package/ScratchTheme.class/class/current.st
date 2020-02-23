accessing
current
	^ CurrentTheme ifNil: [ self error: 'Did not setup any theme yet.' ]