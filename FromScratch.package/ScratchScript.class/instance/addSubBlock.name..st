blocks
addSubBlock: aPoint name: aString
	| morph |
	morph := self newSubMorph
		position: aPoint;
		subName: aString;
		yourself.
	blocksBin addMorph: morph