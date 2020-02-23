other
showValue
	| msg |
	msg := SpScratchApp
		try: [ self evaluate ]
		onFailure: [ :err | 'Error!' localized , err asString ].
	msg ifNil: [ ^ self ].
	msg := self isBooleanReporter
		ifTrue: [ msg localized ]
		ifFalse: [ msg asString ].
	self showBalloon: msg