microworld
aimHighVarNo: vid atPoint: aPoint direction: heading
	| pos id delta forward left right |
	delta := Point r: 1.5 degrees: heading \\ 360.
	pos := aPoint + delta.
	id := self indexAtPoint: pos.
	forward := variables var: vid at: id.
	delta := Point r: 1.5 degrees: (heading + 45) \\ 360.
	pos := aPoint + delta.
	id := self indexAtPoint: pos.
	left := variables var: vid at: id.
	delta := Point r: 1.5 degrees: (heading - 45) \\ 360.
	pos := aPoint + delta.
	id := self indexAtPoint: pos.
	right := variables var: vid at: id.
	^ (forward >= left and: [ forward >= right ])
		ifTrue: [ 0 ]
		ifFalse: [ left >= right
				ifTrue: [ 45 ]
				ifFalse: [ -45 ] ].