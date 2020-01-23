private
ifElseTupleFrom: anArray
	| cond trueBlock falseBlock |
	cond := self tupleFrom: anArray second.
	trueBlock := anArray third.
	trueBlock := trueBlock isEmpty
		ifTrue: [ nil ]
		ifFalse: [ trueBlock collect: [ :each | self tupleFrom: each ] ].
	falseBlock := anArray fourth.
	falseBlock := falseBlock isEmpty
		ifTrue: [ nil ]
		ifFalse: [ falseBlock collect: [ :each | self tupleFrom: each ] ].
	^ {anArray first asSymbol.
	cond.
	trueBlock.
	falseBlock}