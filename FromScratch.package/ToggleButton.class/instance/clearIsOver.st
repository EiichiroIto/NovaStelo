accessing
clearIsOver

	| f |
	isOver ifFalse: [^ self].  "already cleared"
	isOver := false.

	"update my extent"
	f := isOn ifTrue: [onForm] ifFalse: [offForm].
	isDisabled ifTrue: [f := disabledForm].
	f ifNotNil: [self extent: f extent].
