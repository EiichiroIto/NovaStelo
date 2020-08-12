private
labelMorphFor: aString
	| s |
	s := aString.
	"commandSpec isUnicode ifTrue: [s := UTF8 withAll: s].
	self variable isUnicode ifTrue: [s := UTF8 withAll: s]."
	^ (StringMorph contents: s font: ScratchTranslator labelFont)
		color: self labelColor