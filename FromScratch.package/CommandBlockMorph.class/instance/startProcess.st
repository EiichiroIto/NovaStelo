processes
startProcess
	self stopProcess.
	self receiver ifNil: [ ^ self ].
	self applicationDo: [ :app | app startProcessFor: self ].
	self changed