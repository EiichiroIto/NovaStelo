event handling
copyRecordingIn: dict
	"Copy frame morphs for all states."

	| result |
	result := super copyRecordingIn: dict.
	normal ifNotNil: [result normal: (normal copyRecordingIn: dict)].
	pressed ifNotNil: [result pressed: (pressed copyRecordingIn: dict)].
	over ifNotNil: [result over: (over copyRecordingIn: dict)].
	^ result