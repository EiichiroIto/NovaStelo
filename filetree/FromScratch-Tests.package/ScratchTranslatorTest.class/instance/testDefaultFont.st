test
testDefaultFont
	| t |
	t := self newTranslator.
	self assert: (t defaultFont isKindOf: AbstractFont)