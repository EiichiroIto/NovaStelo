event handling
keyboardFocusChange: aBoolean

	hasFocus = aBoolean ifTrue: [^ self].

	self changed.
	aBoolean
		ifTrue: [
			self selectAll.
			self startStepping]
		ifFalse: [
			self stopStepping].

	hasFocus := aBoolean.
