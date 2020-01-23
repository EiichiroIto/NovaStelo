accessing
nestedBlockAt: aPoint

	| dist |
	trueBlock
		ifNotNil: [dist := trueBlock - aPoint.
			falseBlock
				ifNotNil: [(dist > (falseBlock - aPoint))
					ifTrue: [^ falseBlock]
					ifFalse: [^ trueBlock]]
				ifNil: [^ trueBlock]]
		ifNil: [^ falseBlock].
