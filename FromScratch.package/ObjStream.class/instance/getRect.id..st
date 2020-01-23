fixed format-reading
getRect: anObject id: classID

	| x1 y1 x2 y2 |
	firstPass ifTrue: [
		x1 := self readField.
		y1 := self readField.
		x2 := self readField.
		y2 := self readField.
		^ (Point x: x1 y: y1) corner: (Point x: x2 y: y2)].

	"fix references"
	anObject origin
		setX: (self targetObjectFor: anObject origin x)
		setY: (self targetObjectFor: anObject origin y).
	anObject corner
		setX: (self targetObjectFor: anObject corner x)
		setY: (self targetObjectFor: anObject corner y).
