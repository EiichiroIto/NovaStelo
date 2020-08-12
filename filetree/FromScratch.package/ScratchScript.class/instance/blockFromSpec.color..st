blocks
blockFromSpec: spec color: blockColor
	| blockLabelSpec blockType selector defaultArgs block rcvr argPermutation c |
	c := blockColor.
	blockLabelSpec := (spec at: 1) localized.
	argPermutation := CommandBlockMorph
		argPermutationForSpec: (spec at: 1)
		withTranslation: blockLabelSpec.
	blockType := spec at: 2.
	selector := (spec at: 3) asSymbol.
	defaultArgs := self defaultArgsFor: spec.
	(#(E K M S T L G) includes: blockType)
		ifTrue: [ ^ (self hatBlockType: blockType) color: blockColor ].
	(blockType includes: $c)
		ifTrue: [ block := selector = #doIfElse
				ifTrue: [ IfElseBlockMorph new isSpecialForm: true ]
				ifFalse: [ CBlockMorph new isSpecialForm: true ] ]
		ifFalse: [ (blockType includes: $r) | (blockType includes: $b)
				ifTrue: [ block := ReporterBlockMorph new.
					c := c darker ]
				ifFalse: [ block := CommandBlockMorph new ] ].
	(blockType includes: $b)
		ifTrue: [ block isBoolean: true ].
	(blockType includes: $s)
		ifTrue: [ block isSpecialForm: true ].
	(blockType includes: $t)
		ifTrue: [ block isTimed: true ].
	rcvr := self.
	^ block
		argPermutation: argPermutation;
		color: c;
		selector: selector;
		receiver: rcvr;
		commandSpec: blockLabelSpec;
		defaultArgs: defaultArgs;
		yourself