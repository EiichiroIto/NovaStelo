initialization
for: aString event: aSymbol
	| s |
	super initialize.
	self removeAllMorphs.
	s := self newLabelString
		contents: aString;
		yourself.
	self addMorphBack: s.

	"create scriptNameMorph but don't add it"
	scriptNameMorph := EventTitleMorph new eventName: aSymbol.
	self fixBlockLayout