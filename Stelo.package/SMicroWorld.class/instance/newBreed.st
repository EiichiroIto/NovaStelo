private
newBreed
	| breed |
	breed := self observer newTurtle.
	self addBreed: breed.
	^ breed