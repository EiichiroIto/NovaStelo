event handling
mouseUp: evt
	
	(actWhen = #buttonUp and:
	 [self containsPoint: evt cursorPoint])
		ifTrue: [self doButtonAction].

	toggleButtonMode ifFalse: [ self off ].
