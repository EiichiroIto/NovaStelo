fixed format-reading
getPoint: anObject id: classID

	| x y |
	firstPass ifTrue: [
		x := self readField.
		y := self readField.
		^ Point x: x y: y].

	"fix references"
	anObject
		setX: (self targetObjectFor: anObject x)
		setY: (self targetObjectFor: anObject y).
