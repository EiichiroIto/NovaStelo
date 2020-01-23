accessing
label: aString font: aFont
	"Add the given label in the given font centered in my current extent."

	| oldLabel m |
	(oldLabel := self findA: StringMorph) ifNotNil: [oldLabel delete].
	m := StringMorph contents: aString font: (aFont ifNil: [self error]).
	m position: self center - (m extent // 2).
	self addMorph: m.
	m lock.
