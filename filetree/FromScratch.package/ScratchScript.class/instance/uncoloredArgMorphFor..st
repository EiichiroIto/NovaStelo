argument menus
uncoloredArgMorphFor: specString
	| code |
	code := specString at: 2.
	$b = code
		ifTrue: [ ^ BooleanArgMorph new ].
	$e = code
		ifTrue: [ ^ EventTitleMorph new ].
	$f = code
		ifTrue: [ ^ ChoiceArgMorph new
				getOptionsSelector: #mathFunctionNames;
				choice: 'sqrt' ].
	$L = code
		ifTrue: [ ^ ChoiceArgMorph new getOptionsSelector: #listVarNames ].
	$m = code
		ifTrue: [ ^ SpriteArgMorph new ].
	$n = code
		ifTrue: [ ^ ExpressionArgMorph new numExpression: '10' ].
	$S = code
		ifTrue: [ ^ ChoiceArgMorph new
				getOptionsSelector: #subNames;
				choice: '' ].
	$s = code
		ifTrue: [ ^ ExpressionArgMorph new stringExpression: '' ].
	$v = code
		ifTrue: [ ^ ChoiceArgMorph new
				getOptionsSelector: #varNames;
				choice: '' ].
	^ ExpressionArgMorph new numExpression: '10'