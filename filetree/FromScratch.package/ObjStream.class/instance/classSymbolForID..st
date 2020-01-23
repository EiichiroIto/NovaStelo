private-reading
classSymbolForID: classID
	"Answer the class symbol for the given class ID."

	^ (IDToClassEntry at: classID) second