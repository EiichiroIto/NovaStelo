private
labelMorphFor: aString

	| s |
	s := aString.
	"commandSpec isUnicode ifTrue: [s := UTF8 withAll: s]."
	^ (StringMorph contents: s font: (ScratchTheme labelFont))
		color: self labelColor