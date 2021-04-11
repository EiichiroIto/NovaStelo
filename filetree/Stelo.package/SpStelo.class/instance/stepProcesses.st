processes
stepProcesses
	| list |
	process ifNotNil: [ process step ].
	updateInfoCount := updateInfoCount + 1.
	updateInfoCount > self maxUpdateInfoCount
		ifTrue: [ updateInfoCount := 0.
			self updateInfo ].
	presenter updateDisplay.
	recorder ifNotNil: [ recorder writeForced: false ].
	list := sworld plotList.
	list isEmpty
		ifTrue: [ ^ self ].
	presenter addPlots: list