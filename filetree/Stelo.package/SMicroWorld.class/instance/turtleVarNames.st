command
turtleVarNames
	| list |
	list := Set new.
	self turtleBreedsDo: [ :each | list addAll: each userDefinedVarNames ].
	^ list asSortedCollection asArray.