drawing
drawOn: aCanvas

	| form |
	form := isOn ifTrue: [onForm] ifFalse: [offForm].
	isOver & isOn not ifTrue: [form := overForm].
	isDisabled ifTrue: [form := disabledForm].

	form ifNil: [  "default drawing if nil form"
		aCanvas frameRectangle: self bounds
			width: 3
			color: (isOn ifTrue: [Color veryVeryLightGray] ifFalse: [Color gray]).
		^ self].

	alphaOn
		ifTrue: [aCanvas translucentImage: form at: bounds origin]
		ifFalse: [aCanvas paintImage: form at: bounds origin].
