accessing
countBlockMorphs
	| list |
	list := self hatBlocks collect: [ :each | self countBlockMorph: each ].
	list isEmpty ifTrue: [ ^ 0 ].
	^ list sum