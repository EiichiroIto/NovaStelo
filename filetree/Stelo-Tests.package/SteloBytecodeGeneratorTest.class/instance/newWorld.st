private
newWorld
	| w |
	w := SMicroWorld new.
	w addBreed: SPatches new.
	w addBreed: (STurtles new breedNo: 3).
	^ w