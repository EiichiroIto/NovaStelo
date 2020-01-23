accessing
selectButton: aString
	buttonObserver state: aString = buttonObserver label asString.
	buttonPatches state: aString = buttonPatches label asString.
	buttonTurtles state: (aString beginsWith: buttonTurtles label asString)