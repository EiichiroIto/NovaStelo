accessing
forBreedNo: anInteger
	^ breeds at: anInteger ifAbsent: [ #() ]