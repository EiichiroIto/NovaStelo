test
testRandomFromTo
	| t b r |
	b := self newGenerator.
	10
		timesRepeat: [ r := b randomFrom: 1 to: 10.
			self assert: r isNil.
			t := self newThread.
			t codes: b code.
			self assert: ((t evaluate: 1) between: 1 and: 10) ].