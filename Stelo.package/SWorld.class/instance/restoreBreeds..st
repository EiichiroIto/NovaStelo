accessing
restoreBreeds: aCollection
	self reset.
	aCollection do: [ :each | self addBreed: each ]