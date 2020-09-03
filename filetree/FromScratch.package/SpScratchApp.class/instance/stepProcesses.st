processes
stepProcesses
	process ifNotNil: [ process step ].
	updateInfoCount := updateInfoCount + 1.
	updateInfoCount > self maxUpdateInfoCount
		ifTrue: [ updateInfoCount := 0.
			self updateInfo ].
	presenter updateDisplay.
	self stepProcessesHook