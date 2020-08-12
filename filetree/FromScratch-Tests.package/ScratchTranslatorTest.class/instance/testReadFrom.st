test
testReadFrom
	| t s |
	t := self newTranslator.
	s := 'msgid "abc"
msgstr "def"

msgid "ghi"
msgstr "jkl"'.
	t readFrom: (ReadStream on: s).
	self assert: (t textAt: 'abc') equals: 'def'.
	self assert: (t textAt: 'ghi') equals: 'jkl'