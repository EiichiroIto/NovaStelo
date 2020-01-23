button actions
clearTurtles
	project turtleBreeds do: [ :each | sworld clearBreed: each breedNo ].
	presenter updateDisplay