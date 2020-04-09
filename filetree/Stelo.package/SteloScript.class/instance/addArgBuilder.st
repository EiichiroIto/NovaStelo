argument menus
addArgBuilder
	super addArgBuilder.
	argBuilder
		addNumberExpressArg: $c
			selector: #colorMenu
			target: nil
			initialExpression: '15';
		addChoiceArg: $o selector: #observerVarNamesMenu;
		addChoiceArg: $p selector: #patchVarNamesMenu;
		addChoiceArg: $t selector: #turtleVarNamesMenu