private
newWorld
	| w |
	w := SMicroWorld new.
	w addBreed: SObserver new.
	w addBreed: SPatches new.
	w newBreed.
	^ w