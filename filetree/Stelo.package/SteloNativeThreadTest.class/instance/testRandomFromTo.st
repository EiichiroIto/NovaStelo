test
testRandomFromTo
	| t |
	t := self newThread.
	100
		timesRepeat: [ self assert: t stack size equals: 0.
			t push: 5.
			t push: 10.
			t randomFromTo.
			self assert: t stack size equals: 1.
			self assert: (t pop between: 5 and: 10) ].