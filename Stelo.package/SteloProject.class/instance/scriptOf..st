accessing
scriptOf: bno
	^ scripts detect: [ :each | each breed breedNo = bno ]