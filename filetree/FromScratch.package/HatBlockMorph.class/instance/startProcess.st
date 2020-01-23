processes
startProcess
	self stopProcess.
	scriptOwner ifNil: [ ^ self ].
	self applicationDo: [ :app | app startProcessFor: self ].
	self changed