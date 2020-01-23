accessing
turtleBreeds
	^ self breeds reject: [ :each | each breedNo < SBreedId turtleBreedNo ]