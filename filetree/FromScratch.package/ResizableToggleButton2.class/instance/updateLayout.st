private
updateLayout
	"Update the label position within the button."

	| x y top |
	x := ((self width - label2 width) // 2) + hOffset.  "center by default"
	justification = #left ifTrue: [x := hOffset].
	justification = #right ifTrue: [x := self width - hOffset - label2 width].

	y := ((self height / 2) - vOffset) rounded.

	top := self top + 10.
	(self submorphs size = 2)
		ifTrue: [label2 position: self position + (x@y)]
		ifFalse: [self submorphs reversed do: [:m |
			(m isKindOf: ImageFrameMorph) ifFalse: [
				m left: self left + ((self width - m width) // 2).
				m top: top.
				top := m bottom + 6]]].
