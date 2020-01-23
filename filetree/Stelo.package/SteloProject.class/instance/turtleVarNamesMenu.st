argument menus
turtleVarNamesMenu
	| list |
	list := Set new.
	self turtleBreeds
		do: [ :each | list addAll: each userDefinedVarNames ].
	^ list asSortedCollection asArray