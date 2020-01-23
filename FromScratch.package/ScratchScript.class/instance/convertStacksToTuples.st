object i/o
convertStacksToTuples
	"Convert my blocks bin from a morph containing block stack into a collection of (<point>, <tuple>) pairs the represent the same stacks in compact, language-independent form."

	| stacks blocks comments |
	blocksBin isArray
		ifTrue: [ ^ self ].
	stacks := blocksBin submorphs
		select: [ :m | m respondsTo: #tupleSequence ].
	blocks := stacks select: [ :m | m isBlockMorph ].
	comments := stacks select: [ :m | m isCommentMorph ].
	blocks := blocks
		collect: [ :blockM | 
			Array
				with: blockM position - blocksBin position
				with: blockM tupleSequence ].
	comments := comments
		collect: [ :blockM | 
			Array
				with: blockM position - blocksBin position
				with: blockM tupleSequence ].
	blocksBin := blocks , comments