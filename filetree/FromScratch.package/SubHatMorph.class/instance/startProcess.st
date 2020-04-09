processes
startProcess
	| proc |
	self receiver ifNil: [ ^ self ].
	proc := self applicationDo: [ :app | app startProcessFor: self ].
	self changed.
	^ proc