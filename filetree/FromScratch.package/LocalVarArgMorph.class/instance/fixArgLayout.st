private
fixArgLayout
	| xInset |
	self extent: labelMorph extent + (2 @ 0) + (iconMorph width @ 0).
	xInset := 3.
	labelMorph position: (self left + xInset) @ self top.
	iconMorph position: labelMorph right @ self top