sensing ops
getTurtle: tno breed: bno var: var
	^ bcGenerator
		getVar: [ :b | targetMorph varFor: var choice breed: b ]
		breedNo: [ bno argString: parser ]
		index: [ tno argString: parser ]