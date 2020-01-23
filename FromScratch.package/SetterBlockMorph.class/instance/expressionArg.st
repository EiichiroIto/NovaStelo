accessing
expressionArg

	submorphs do: [:m |
		(m isKindOf: ExpressionArgMorph) ifTrue: [^ m]].

	^ nil