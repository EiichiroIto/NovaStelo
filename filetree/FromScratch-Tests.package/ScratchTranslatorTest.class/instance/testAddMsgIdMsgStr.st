test
testAddMsgIdMsgStr
	| t |
	t := self newTranslator.
	t addMsgId: 'abc' msgStr: 'def'.
	t addMsgId: '"ghi"' msgStr: '"jkl"'.
	t addMsgId: '""' msgStr: '"mno"'.
	self assert: (t textAt: 'abc') equals: 'def'.
	self assert: (t textAt: 'ghi') equals: 'jkl'.
	self assert: t texts size equals: 2