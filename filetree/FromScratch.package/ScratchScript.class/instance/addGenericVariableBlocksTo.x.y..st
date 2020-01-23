blocks
addGenericVariableBlocksTo: page x: x y: startY
	"Add the generic variable blocks to the given page starting at the given y offset. Answer the new y."

	| y vName block varBlocks |
	y := startY.

	"pick a default variable name"
	self varNames isEmpty
		ifTrue: [ ^ y ].
	vName := self varNames first.
	varBlocks := OrderedCollection new.
	block := SetterBlockMorph new
		receiver: self;
		initSetterForVar: vName.
	block expressionArg stringExpression: '0'.
	varBlocks add: block.
	block := SetterBlockMorph new
		receiver: self;
		initChangerForVar: vName.
	block expressionArg numExpression: '1'.
	varBlocks add: block.
	(self blocksFor: 'variables')
		do: [ :b | 
			b defaultArgs: (Array with: vName).
			varBlocks add: b ].
	varBlocks
		do: [ :b | 
			b color: ScratchTheme variableBlockColor.
			page addMorph: (b position: x @ y).
			y := b bottom + 3 ].
	^ y