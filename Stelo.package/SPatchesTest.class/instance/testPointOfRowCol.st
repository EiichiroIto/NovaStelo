tests-private
testPointOfRowCol
	| ps pos |
	ps := SPatches new.
	ps create: 5.
	pos := ps pointOfRow: 1 col: 1.
	self assert: pos equals: -2 @ -2.
	pos := ps pointOfRow: 5 col: 1.
	self assert: pos equals: 2 @ -2.
	pos := ps pointOfRow: 3 col: 3.
	self assert: pos equals: 0 @ 0.
	pos := ps pointOfRow: 5 col: 5.
	self assert: pos equals: 2 @ 2.
	ps create: 6.
	pos := ps pointOfRow: 1 col: 1.
	self assert: pos equals: -3 @ -3.
	pos := ps pointOfRow: 6 col: 1.
	self assert: pos equals: 2 @ -3.
	pos := ps pointOfRow: 4 col: 4.
	self assert: pos equals: 0 @ 0.
	pos := ps pointOfRow: 6 col: 6.
	self assert: pos equals: 2 @ 2.