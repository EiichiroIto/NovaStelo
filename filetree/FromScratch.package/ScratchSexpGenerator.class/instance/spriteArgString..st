arg generator
spriteArgString: aMorph
	aMorph ifNil: [ self error ].
	^ aMorph objName