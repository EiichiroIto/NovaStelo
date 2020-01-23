event handling
mouseLeave: evt

	isDisabled ifTrue: [^ self].

	overForm ifNotNil: [
		self changed.
		isOver := false.
		isOn ifTrue: [self on] ifFalse: [self off]].
