test
testDoRepeatBegin
	| b t arr |
	b := self newGenerator.
	b appendValue: false.
	arr := b doRepeatBegin: 5.
	b doRepeatEndLabels: arr.
	t := self newThread.
	t codes: b code.
	t execute: 1.