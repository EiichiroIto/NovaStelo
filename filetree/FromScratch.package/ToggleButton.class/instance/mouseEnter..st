event handling
mouseEnter: evt

	isDisabled ifTrue: [^ self].

	overForm ifNotNil: [
		self changed.
		isOver := true.
		self extent: overForm extent.
		self changed].
