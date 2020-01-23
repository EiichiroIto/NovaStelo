blocks
blockIDOf: aMorph
	| list |
	list := blocksBin allMorphs select: [ :each | each isBlockMorph ].
	^ list indexOf: aMorph