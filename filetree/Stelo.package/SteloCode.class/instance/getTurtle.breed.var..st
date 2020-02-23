sensing ops
getTurtle: tno breed: bno var: var
	^ generator
		getVar: [ :b | script varNoFor: var choice breed: b ]
		breedNo: [ bno argString: parser ]
		index: [ tno argString: parser ]