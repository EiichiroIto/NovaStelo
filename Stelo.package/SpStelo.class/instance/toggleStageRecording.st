menu actions
toggleStageRecording
	self isRecording
		ifTrue: [ self stopStageRecording ]
		ifFalse: [ self startStageRecording ]