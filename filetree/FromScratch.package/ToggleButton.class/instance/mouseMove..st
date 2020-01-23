event handling
mouseMove: evt
	"Give feedback depending on whether the mouse is over me. If I was originally on, show my off image if the mouse is over me and my on image if not. Do the opposite if I was originally off."

	isDisabled ifTrue: [^self].

	actWhen == #buttonDown ifTrue: [^ self].
	(toggleMode not & wasOn) ifTrue: [^ self].  "already on and not toggling"
	(self containsPoint: evt cursorPoint)
		ifTrue: [wasOn ifTrue: [self off] ifFalse: [self on]]
		ifFalse: [wasOn ifTrue: [self on] ifFalse: [self off]].
