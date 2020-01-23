private
replaceTabs: aString
	"Answer a copy of the given UTF32 with each tab replaced by four spaces and all non-printing characters except spaces and line ends removed. Covert LF's to CR's."

	| s tab lf cr space result |
	s := aString.
	tab := Character tab.
	lf := Character lf.
	cr := Character cr.
	space := Character space.
	result := WriteStream on: (String new: s size * 4).
	s do: [:ch |
		ch < space
			ifTrue: [ "non-printing"
				ch = tab ifTrue: [result nextPutAll: '    '].
				(ch = cr) | (ch = lf) ifTrue: [result nextPut: cr]]
			ifFalse: [
				result nextPut: ch]].

	^ result contents
