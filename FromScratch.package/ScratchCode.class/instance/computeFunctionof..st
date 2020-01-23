arithmetic ops
computeFunctionof: aMorph
	| op v |
	op := aMorph blockArgs first choice asSymbol.
	op = 'e ^'
		ifTrue: [ op := 'exp' ].
	op = '10 ^'
		ifTrue: [ op := 'exp10' ].
	v := [ aMorph blockArgs second argString: parser ].
	^ bcGenerator computeFunction: op asSymbol of: v