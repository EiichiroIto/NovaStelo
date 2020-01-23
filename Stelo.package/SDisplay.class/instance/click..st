event handling
click: evt
	| p |
	p := evt cursorPoint - self topLeft.
	p := self pointOf: p.
	self showBalloon: p asString