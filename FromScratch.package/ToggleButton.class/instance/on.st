accessing
on
	"Turn myself on."

	isOn ifTrue: [^ self].
	self changed.
	isOn := true.
	onForm ifNotNil: [self extent: onForm extent].
	self changed.
