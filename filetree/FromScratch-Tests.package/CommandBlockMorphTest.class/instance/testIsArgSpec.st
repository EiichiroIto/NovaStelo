test
testIsArgSpec
	self assert: (CommandBlockMorph isArgSpec: '%a').
	self assert: (CommandBlockMorph isArgSpec: '%b').
	self deny: (CommandBlockMorph isArgSpec: '%').
	self deny: (CommandBlockMorph isArgSpec: 'x')