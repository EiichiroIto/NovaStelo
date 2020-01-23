menu actions
stopStageRecording
	recorder ifNil: [ ^ self ].
	recorder close.
	recorder := nil.
	self updateStatus