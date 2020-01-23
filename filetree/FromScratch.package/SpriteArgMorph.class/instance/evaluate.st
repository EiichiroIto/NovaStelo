other
evaluate
	"Answer either nil, the symbol #mouse, or a Scratch sprite object."

	self checkForDeletedMorph.
	morph isString
		ifTrue: [ morph := owner script project findObjName: morph ].
	^ morph