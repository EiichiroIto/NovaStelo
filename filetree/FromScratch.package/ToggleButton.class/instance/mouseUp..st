event handling
mouseUp: evt
	"If I am a momentary button, then turn off. If I am to act on button up, then send my target my action selector."

	isDisabled ifTrue:[^ self].

	isMomentary ifTrue: [self off].

	(actWhen == #buttonUp and:
	 [self containsPoint: evt cursorPoint])
		ifTrue: [self doButtonAction].
