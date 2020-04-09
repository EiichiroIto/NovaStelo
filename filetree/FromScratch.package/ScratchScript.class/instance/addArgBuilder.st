argument menus
addArgBuilder
	argBuilder
		addBooleanArg: $b;
		addEventTitleArg: $e;
		addChoiceArg: $f selector: #mathFunctionNames initialChoice: 'sqrt';
		addLocalVarArg: $l;
		addChoiceArg: $L selector: #listVarNames;
		addSpriteArg: $m;
		addNumberExpressArg: $n initialExpression: '10';
		addChoiceArg: $S selector: #subNames;
		addStringExpressArg: $s;
		addChoiceArg: $v selector: #varNames