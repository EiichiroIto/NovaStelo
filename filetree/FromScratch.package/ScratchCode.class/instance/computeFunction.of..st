arithmetic ops
computeFunction: operator of: num
	| op |
	op := operator choice.
	op = 'e ^'
		ifTrue: [ op := 'exp' ].
	op = '10 ^'
		ifTrue: [ op := 'exp10' ].
	^ generator
		computeFunction: op asSymbol
		of: [ num argString: parser ]