accessing
over
	"Show my over skin."

	"toggleButtonMode ifFalse: [^ self]."
	isOn ifTrue: [^ self].
	over ifNil: [^ self].

	self setCurrent: over.
	label2 color: labelColorOver.
