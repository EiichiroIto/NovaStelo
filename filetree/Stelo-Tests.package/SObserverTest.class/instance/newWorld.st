private
newWorld
	| w |
	w := SMicroWorld new.
	w addBreed: (SObserver new sworld: w).
	w addBreed: SPatches new.
	w newBreed.
	^ w