private
pickColor
	"Pick a colour from the screen."

	| position c hand |
	hand := self activeHand.
	hand showTemporaryCursor: Cursor eyeDropper.
	hand
		captureEventsUntil: [ :evt | 
			evt isMove
				ifTrue: [ 
					position := evt position.
					c := Color colorFromPixelValue: ((Display pixelValueAt: position) bitOr: 16rFF000000) depth: 32.
					hand position: position.
					self color: c.
					owner invalidRect: self bounds ].
			hand anyButtonPressed ].
	hand showTemporaryCursor: nil