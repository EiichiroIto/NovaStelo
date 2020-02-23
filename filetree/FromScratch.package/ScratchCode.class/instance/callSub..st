control ops
callSub: subName
	| str |
	str := subName choice.
	str isEmpty
		ifTrue: [ ^ self ].
	generator callSub: str.