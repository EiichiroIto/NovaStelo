acccessing
import: aString to: anApplication
	| lex list |
	project := anApplication project.
	lex := SexpLexer new read: aString.
	list := SexpParser new parse: lex.
	self importWorld: list.