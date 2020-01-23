accessing
setLabelColor: aColor

	| s |
	s := self findA: StringMorph.
	s color: aColor.
