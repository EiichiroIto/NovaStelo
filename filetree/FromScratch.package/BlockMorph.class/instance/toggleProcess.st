processes
toggleProcess
	self
		applicationDo: [ :app | 
			app isProcessRunning
				ifTrue: [ self stopProcess ]
				ifFalse: [ self startProcess ] ]