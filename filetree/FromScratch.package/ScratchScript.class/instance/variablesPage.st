blocks
variablesPage
	| page y maxX |
	page := self newBlockPaletteMorph
		isForScript: true;
		color: (Color r: 0.8 g: 0.8 b: 1.0);
		borderWidth: 0.
	y := 7.
	self useVariable
		ifTrue: [ y := self addGenericVariableBlocksTo: page y: y ].
	self useList
		ifTrue: [ y := self addGenericListBlocksTo: page y: y ].
	maxX := page submorphs inject: 0 into: [ :t :m | t max: m right ].
	page extent: (maxX + 10) @ y.
	^ page