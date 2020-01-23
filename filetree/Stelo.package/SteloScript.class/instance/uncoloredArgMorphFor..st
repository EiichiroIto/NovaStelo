argument menus
uncoloredArgMorphFor: specString
	"Answer an argument morph for the given argument specification string."

	| code |
	code := specString at: 2.
	$c = code
		ifTrue: [ ^ ExpressionArgMorphWithMenu new
				numExpression: '15';
				menuSelector: #colorMenu ].
	$d = code
		ifTrue: [ ^ ExpressionArgMorphWithMenu new
				numExpression: '0';
				menuSelector: #directionMenu ].
	$k = code
		ifTrue: [ ^ ChoiceArgMorph new
				getOptionsSelector: #keyNames;
				choice: 'space' ].
	$o = code
		ifTrue: [ ^ ChoiceArgMorph new
				getOptionsSelector: #observerVarNamesMenu;
				choice: '' ].
	$p = code
		ifTrue: [ ^ ChoiceArgMorph new
				getOptionsSelector: #patchVarNamesMenu;
				choice: '' ].
	$t = code
		ifTrue: [ ^ ChoiceArgMorph new
				getOptionsSelector: #turtleVarNamesMenu;
				choice: '' ].
	^ super uncoloredArgMorphFor: specString