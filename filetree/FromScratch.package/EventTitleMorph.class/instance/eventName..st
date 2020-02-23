accessing
eventName: aString
	| block |
	labelMorph contents: aString asString.
	labelMorph position: self position + borderWidth + (3 @ -1).
	self extent: labelMorph extent + (16 @ 2) + borderWidth.
	menuIconMorph
		position: (self right - borderWidth - 10) @ (self top + borderWidth + 4).
	(block := self meOrOwnerThatIsA: HatBlockMorph)
		ifNotNil: [ block fixBlockLayout ]