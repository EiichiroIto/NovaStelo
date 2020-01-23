private
updateStatus
	| str |
	str := ' (', sworld worldName, ')'.
	self isRecording
		ifTrue: [ str := str, ' (Recording)' ].
	presenter status: str