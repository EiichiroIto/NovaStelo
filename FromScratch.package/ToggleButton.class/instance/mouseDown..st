event handling
mouseDown: evt
	"If I am currently turned on, turn myself off and vice versa. If toggleMode is false, then do nothing if I am already on. If isMomentary, then turn myself off immediately. If I am to act when I'm pressed, then send my target my action selector."

	"evt hand toolType: nil."
	isDisabled ifTrue: [^ self].

	wasOn := isOn.
	actWhen == #buttonDown ifTrue: [
		self doButtonAction.
		self on.
		isMomentary ifTrue: [self off]].
